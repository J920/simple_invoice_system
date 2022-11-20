import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import '../data/invoice.dart';
import '../data/item.dart';
import '../data/local_user.dart';

class FirebaseService extends GetxService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _firestorage = FirebaseStorage.instance;
  late final DocumentReference<Map<String, dynamic>> generalConfigurations;
  final LocalUser user = LocalUser();

  @override
  void onInit() {
    generalConfigurations = _firestore.collection("Configurations").doc("general");
    if (_auth.currentUser != null) {
      user.email = _auth.currentUser!.email?.toLowerCase();
      updateUserDetail();
    }
  }

  bool isLoggedIn(){
    return _auth.currentUser != null;
  }

  Future<Response> register() async{
      try {

        await _auth.createUserWithEmailAndPassword(
            email: user.email!,
            password: user.password!
        );

        // Upload file
        var uploadedLogo = await _firestorage.ref('stores/${user.email!}/logo.${user.logoExtension}').putFile(user.logo!);

        await _firestore.collection("Store").doc(user.email!).set({
          "name": user.name,
          "address": user.address,
          "logo": await uploadedLogo.ref.getDownloadURL(),
          "vat_number": user.vatNumber
        });

        updateUserDetail();

      } on FirebaseException catch (e) {
        return Response(statusCode: 403, statusText: e.message);
      } catch (e) {
        return Response(statusCode: 403, statusText: "حصل خطأ غير متوقع!");
      }
      user.password = "";
    return const Response(statusCode: 200);
  }

  Future<Response> logIn() async{
    try {
      await _auth.signInWithEmailAndPassword(
          email: user.email!,
          password: user.password!
      );

      updateUserDetail();

    } on FirebaseException catch (e) {
      return Response(statusCode: 403, statusText: e.message);
    } catch (e) {
      return const Response(statusCode: 403, statusText: "حصل خطأ غير متوقع!");
    }
    user.password = "";
    return const Response(statusCode: 200);
  }

  Future<bool> signOut() async{
    try {
      await _auth.signOut();
    } catch (e) {
      return false;
    }
    return true;

  }


  Future<int> getVatRate()  async{
    var generalConfigurationsSnapshot = await generalConfigurations.get();
    return generalConfigurationsSnapshot.get("vat_rate");
  }

  Future<Response<Invoice>> createInvoice({required Invoice invoice, var pdf}) async{

    try {



      var doc = await _firestore.collection("Store").doc(user.email!).collection("Invoices").add({
        "buyer_name": invoice.buyerName,
        "vat_rate": invoice.vatRate,
        "date": invoice.date,
        "total_excl_vat": invoice.totalExclVat,
        "vat_amount": invoice.vatAmount,
        "total": invoice.totalInclVat,
        "items": invoice.itemsList.map((item) =>
          {
            "id": item.id,
            "description": item.description,
            "unit_price": item.price,
            "quantity": item.quantity.value,
            "total_excel": item.totalExclVat,
            "vat_rate": item.vatRate,
            "vat_amount": item.vatAmount,
            "total": item.total,
          },
          ).toList()
      });
      updateItemsStock(items: invoice.itemsList);
      invoice.serialNumber = doc.id;


    } on FirebaseException catch (e) {
      return Response(statusCode: 403, statusText: e.message);
    } catch (e) {
      return Response(statusCode: 403, statusText: e.toString());
    }

    return Response(statusCode: 200, body: invoice, );
  }


  updateItemsStock({required List<Item> items}) {
    try{
      items.forEach((element) async{
        await _firestore.collection("Items").doc(element.id).update({
          "stock": FieldValue.increment(-element.quantity.value) ,
        });
      });

    }catch(e){
      printError(info: e.toString());
    }
  }

  Future<Response> uploadPDFInvoice ({required Uint8List pdf, required String serialNumber}) async{

    try {

      var uploadedInvoice = await _firestorage.ref('stores/${user.email!}/invoices/$serialNumber.pdf').putData(pdf);
      await _firestore.collection("Store").doc(user.email!).collection("Invoices").doc(serialNumber).update({
        "pdf_link": await uploadedInvoice.ref.getDownloadURL(),
      });

    } on FirebaseException catch (e) {
      return Response(statusCode: 403, statusText: e.message);
    } catch (e) {
      return Response(statusCode: 403, statusText: e.toString());
    }

    return const Response(statusCode: 200, );

  }

  Future<Response<QuerySnapshot<Map<String, dynamic>>>> getItems() async{
    QuerySnapshot<Map<String, dynamic>> result;
    try {
      result = await _firestore.collection('Items').get();
    }catch(e){
      return Response(statusCode: 403, statusText: e.toString());
    }
    return Response(statusCode: 200, body: result);
  }

  updateUserDetail() async{
    var doc = await _firestore.collection("Store").doc(user.email!).get();
    user.logoUrl = await doc.get("logo");
    user.name = await doc.get("name");
    user.address = await doc.get("address");
    user.vatNumber = await doc.get("vat_number");
  }


}
