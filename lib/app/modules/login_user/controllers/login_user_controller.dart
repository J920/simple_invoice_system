import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_invoice_system/app/constants/app_constants.dart';
import 'package:simple_invoice_system/app/routes/app_pages.dart';

class LoginUserController extends GetxController {
  //TODO: Implement LoginUserController

  final formLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  String phoneNumber = "";




  void login() async {
    formLoading.value = true;
    await userNotExist() ? success() : failed(message: "يوجد مستخدم مسجل برقم الهاتف المدخل");
  }

  Future<bool> userNotExist() async {
    bool exist = true;
    // await _firestore.collection("Subscribers").where(
    //     "phoneNumber", isEqualTo: phoneNumber).get().then((value) =>
    // {
    //   exist = value.size == 0
    // });
    return exist;
  }

  void success() async {
    // try {
    //   try {
    //     await _auth.createUserWithEmailAndPassword(
    //         email: "${phoneNumber}$kEmailDomain",
    //         password: password
    //     );
    //
    //     await _firestore.collection("Subscribers").doc(
    //         "${phoneNumber}$kEmailDomain").set({
    //       "phoneNumber": phoneNumber,
    //       "email": email,
    //       "name": name
    //     });

    Get.toNamed(Routes.CART);
    //   } on FirebaseAuthException catch (e) {
    //     if (e.code == 'weak-password') {
    //       print('The password provided is too weak.');
    //     } else if (e.code == 'email-already-in-use') {
    //       print('The account already exists for that email.');
    //     }
    //   } catch (e) {
    //     print(e);
    //   }
    // } catch (e) {}
  }

  void failed({String? message}) {
    GetSnackBar(
      titleText: Text("خطأ", style: TextStyle(color: kPrimaryColor),),
      messageText: Text(message ?? "حصل خطأ اثناء تسجيل المستخدم"),
      backgroundColor: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
      snackStyle: SnackStyle.FLOATING,
    ).show();
    // Get.snackbar("خطأ", message ?? "حصل خطأ اثناء تسجيل المستخدم", borderColor: Colors.white,).show();
    formLoading.value = false;
  }

}
