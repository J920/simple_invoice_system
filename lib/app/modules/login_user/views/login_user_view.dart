import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../generated/locales.g.dart';
import '../../../constants/app_constants.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_user_controller.dart';

class LoginUserView extends GetView<LoginUserController> {
  const LoginUserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: ModalProgressHUD(
        inAsyncCall: controller.formLoading.value,
        // inAsyncCall: false,
        child: Container(
          decoration: kContainerDecoration,
          padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding, vertical: kDefaultPadding),
          child: Form(
            key: controller.formKey,
            child: ListView(
              // physics: BouncingScrollPhysics(),
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  constraints: BoxConstraints(
                    minHeight: 20,
                    maxHeight: 180,
                  ),
                  child: Center(
                    child: Text(
                      LocaleKeys.login.tr,
                      style: TextStyle(
                        color: kBlackColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                TextFormField(
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || !GetUtils.isEmail(value)) {
                      return "الرجاء ادخال بريد الكتروني صحيح";
                    }
                  },
                  decoration: kMainTextFieldDecoration.copyWith(
                    hintText: "البريد الإلكتروني",
                  ),
                ),
                SizedBox(
                  height: kSpacing,
                ),
                TextFormField(
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.visiblePassword,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value == "" || value.length < 6) {
                      return "الرجاء ادخال كلمة مرور بطول 6 أو أكثر";
                    }
                  },
                  decoration: kMainTextFieldDecoration.copyWith(
                    hintText: "كلمة المرور",
                  ),
                ),
                SizedBox(
                  height: kSpacing,
                ),
                Container(
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        if (controller.formKey.currentState!.validate()) {
                          controller.login();
                        }
                      },
                      child: Text(LocaleKeys.login.tr)),
                ),
                SizedBox(
                  height: kSpacing,
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Text(
                      "ليس لديك حساب؟ ",
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.REGISTER_USER);
                      },
                      child: Text(
                        LocaleKeys.signup.tr,
                        style: TextStyle(
                            color: kBlackColor, fontWeight: FontWeight.bold
                            // decoration: TextDecoration.underline,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
