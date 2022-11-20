import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:simple_invoice_system/app/network/firebase_service.dart';

import '../../../constants/app_constants.dart';
import '../../../routes/app_pages.dart';

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
  final logoFieldController = TextEditingController();
  final Rx<FilePickerResult?> logo = Rx<FilePickerResult?>(null);


  void pickLogo() async{
    logo.value = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    logoFieldController.text = logo.value?.files.first.name ?? "";
  }

  void register() async {
    formLoading.value = true;

    _firebaseService.user.email = email;
    _firebaseService.user.password = password;

    _firebaseService.user.name = name;
    _firebaseService.user.vatNumber = vatNumber;
    _firebaseService.user.address = address;
    _firebaseService.user.logo = File(logo.value?.paths.first! ?? "");
    _firebaseService.user.logoExtension = logo.value?.files.first.extension;

    var response = await _firebaseService.register();
    response.isOk
        ? Get.toNamed(
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
