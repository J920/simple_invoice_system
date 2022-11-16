import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../data/invoice.dart';
import '../data/item.dart';
import '../data/local_user.dart';

class FirebaseService extends GetxService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late final StreamSubscription<QuerySnapshot<Map<String, dynamic>>> listener;
  final LocalUser user = LocalUser();

  @override
  void onInit() {
    if (_auth.currentUser != null) {
    }
  }

  Future<Response> register() async{


      try {
        await _auth.createUserWithEmailAndPassword(
            email: user.email!,
            password: user.password!
        );

        // await _firestore.collection("Subscribers").doc(user.email!).set({
        //   "email": user.email,
        //   "name": user.name
        // });

      } on FirebaseException catch (e) {
        //
        // if (e.code == 'weak-password') {
        //   print('The password provided is too weak.');
        //
        //
        // } else if (e.code == 'email-already-in-use') {
        //   print('The account already exists for that email.');
        // }

        return Response(statusCode: 403, statusText: e.message);


      } catch (e) {
        print(e);
      }

    return const Response(statusCode: 200);
  }

  bool logIn() {
    print(user.name);
    return true;
  }

  Response<Invoice> createInvoice({required Invoice invoice}) {
    return  Response(body: invoice);
  }

  Response<List<Invoice>> getInvoices() {
    return Response(body: []);
  }

  void setItemsListener({required Function(QuerySnapshot<Map<String, dynamic>>) eventAction}) {
    listener = _firestore.collection('Items').snapshots().listen(eventAction);
  }

  void cancelItemsListener({required Function(QuerySnapshot<Map<String, dynamic>>) eventAction}) {
    listener.cancel();
  }

  List<Item> getItems() {
    return [];
  }
}
