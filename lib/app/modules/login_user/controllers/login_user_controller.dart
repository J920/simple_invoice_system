import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_invoice_system/app/constants/app_constants.dart';
import 'package:simple_invoice_system/app/routes/app_pages.dart';

import '../../../network/firebase_service.dart';

class LoginUserController extends GetxController {
  //TODO: Implement LoginUserController

  final FirebaseService _firebaseService = Get.find();
  final formLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";




  void login() async {
    formLoading.value = true;
    _firebaseService.user.email = email;
    _firebaseService.user.password = password;

    var response = await _firebaseService.logIn();
    response.isOk
        ? Get.offAndToNamed(
      Routes.CART,
    )
        : GetSnackBar(
      titleText: Text(
        response.statusCode.toString(),
        style: const TextStyle(color: kPrimaryColor),
      ),
      messageText:
      Text(response.statusText ?? "حصل خطأ اثناء تسجيل المستخدم"),
      backgroundColor: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 5),
      snackStyle: SnackStyle.FLOATING,
    ).show();

    formLoading.value = false;
  }

}
