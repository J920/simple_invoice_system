import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:simple_invoice_system/app/constants/app_constants.dart';
import 'package:simple_invoice_system/app/network/firebase_service.dart';
import 'package:simple_invoice_system/app/routes/app_pages.dart';
import 'dart:ui' as dart;

class RegisterUserController extends GetxController {
  //TODO: Implement RegisterUserController

  final FirebaseService _firebaseService = Get.find();
  final formLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  String name = "";
  String vatNumber = "";
  String address = "";
  String email = "";
  String password = "";
  String confirmPassword = "";
  dart.Image? logo;

  void register() async {
    formLoading.value = true;
    _firebaseService.user.email = email;
    _firebaseService.user.password = password;

    _firebaseService.user.vatNumber = vatNumber;
    _firebaseService.user.address = address;
    _firebaseService.user.logo = logo;

    var response = await _firebaseService.register();
    response.isOk
        ? Get.toNamed(
            Routes.CART,
          )
        : GetSnackBar(
            titleText: Text(
              response.statusCode.toString(),
              style: TextStyle(color: kPrimaryColor),
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
