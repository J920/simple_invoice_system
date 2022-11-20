import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/item.dart';
import '../../../network/firebase_service.dart';
import '../../../routes/app_pages.dart';
import '../../../util/vat_calculator.dart';

class CartController extends GetxController {

  final FirebaseService _firebaseService = Get.find();
  String? logoUrl;
  final total = 0.0.obs;
  int vatRate = 15;
  VatCalculator calculator = VatCalculator();
  final itemsList = [].obs;
  final RxList<Item> selectedItemsList = RxList<Item>();


  @override
  void onInit() async{

    vatRate = await _firebaseService.getVatRate();
   getItems();
    logoUrl = _firebaseService.user.logoUrl;

  }

  void calculateTotal(){
    total.value = 0;
    for (var element in selectedItemsList) {
      total.value = total.value + element.total;
    }

  }

  signOut() async {
    await _firebaseService.signOut()
    ? Get.offAllNamed(Routes.LOGIN_USER)
    : const GetSnackBar(
      messageText:
      Text("حصل خطأ غير متوقع"),
      backgroundColor: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 5),
      snackStyle: SnackStyle.FLOATING,
    ).show();
  }

  getItems() async{
    var response = await _firebaseService.getItems();
    if(response.isOk)
      for(var doc in response.body!.docs){
        itemsList.clear();
        itemsList.add(
          Item(
            id: doc.id,
            description: doc.get("description"),
            stock: doc.get("stock"),
            basePrice: doc.get("price").toDouble(),
            quantity: 1.obs,
            vatRate: vatRate,
          ),
        );
        total.value = 0;
        selectedItemsList.clear();
      }
  }

}

