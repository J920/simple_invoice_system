import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../generated/locales.g.dart';
import '../../../constants/app_constants.dart';
import '../../../routes/app_pages.dart';
import '../controllers/register_user_controller.dart';

class RegisterUserView extends GetView<RegisterUserController> {
  const RegisterUserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return ModalProgressHUD(
          inAsyncCall: controller.formLoading.value,
          child: Container(
            decoration: kContainerDecoration,
            child: Form(
              key: controller.formKey,
              child: ListView(
                padding: EdgeInsets.all(kDefaultPadding),
                physics: BouncingScrollPhysics(),
                children: [
                  Container(
                    constraints: BoxConstraints(
                      minHeight: 20,
                      maxHeight: 180,
                    ),
                    child: Center(
                      child: Text(
                        LocaleKeys.signup.tr,
                        style: TextStyle(
                          color: kBlackColor,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  // Spacer(),
                  TextFormField(
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value == "") {
                        return LocaleKeys.error_massages_name.tr;
                      }
                    },
                    onChanged: (value) {
                      controller.name = value;
                    },
                    decoration: kMainTextFieldDecoration.copyWith(
                      hintText: LocaleKeys.name.tr,
                    ),
                  ),
                  SizedBox(
                    height: kSpacing,
                  ),
                  TextFormField(
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: false),
                    validator: (value) {
                      if (value == null || value == "" || value.length < 10) {
                        return LocaleKeys.error_massages_name.tr;
                      }
                    },
                    onChanged: (value) {
                      controller.vatNumber = value;
                    },
                    decoration: kMainTextFieldDecoration.copyWith(
                      hintText: LocaleKeys.vat_number.tr,
                    ),
                  ),
                  SizedBox(
                    height: kSpacing,
                  ),
                  TextFormField(
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.streetAddress,
                    validator: (value) {
                      if (value == null || value == "") {
                        return LocaleKeys.error_massages_name.tr;
                      }
                    },
                    onChanged: (value) {
                      controller.address = value;
                    },
                    decoration: kMainTextFieldDecoration.copyWith(
                      hintText: LocaleKeys.address.tr,
                    ),
                  ),
                  SizedBox(
                    height: kSpacing,
                  ),

                  TextFormField(
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value == "") {
                        return LocaleKeys.error_massages_name.tr;
                      }
                    },
                    onChanged: (value) {
                      controller.email = value;
                    },
                    decoration: kMainTextFieldDecoration.copyWith(
                      hintText: LocaleKeys.email.tr,
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
                        return LocaleKeys.error_massages_password.tr;
                      }
                    },
                    decoration: kMainTextFieldDecoration.copyWith(
                      hintText: LocaleKeys.password.tr,
                    ),
                    onChanged: (value) {
                      controller.password = value;
                    },
                  ),

                  SizedBox(
                    height: kSpacing,
                  ),
                  TextFormField(
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value == "" || value != controller.password) {
                        return LocaleKeys.error_massages_confirm_password.tr;
                      }
                    },
                    decoration: kMainTextFieldDecoration.copyWith(
                      hintText: LocaleKeys.confirm_password.tr,
                    ),
                  ),

                  SizedBox(
                    height: kSpacing,
                  ),

                  TextFormField(
                    onTap: () => controller.pickLogo(),
                    readOnly: true,
                    controller: controller.logoFieldController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.visiblePassword,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return LocaleKeys.error_massages_logo.tr;
                      }
                    },
                    decoration: kMainTextFieldDecoration.copyWith(
                      hintText: LocaleKeys.logo.tr,
                      suffixIcon: controller.logo.value != null
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(kBorderRadius),
                          child: Image.file(File(controller.logo.value?.paths.first! ?? ""), height: 72, ),
                      )
                          : Icon(Icons.image_search),
                    ),
                  ),

                  SizedBox(
                    height: kSpacing,
                  ),
                  SizedBox(
                    height: kSpacing,
                  ),
                  Wrap(
                    children: [
                      Text(
                        "بالضغط على إنشاء حساب جديد تكون موافق على ",
                      ),
                      Text(
                        "الشروط والأحكام",
                        style: TextStyle(
                          color: kBlackColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: kSpacing,
                  ),
                  Container(
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          if (controller.formKey.currentState!.validate()) {
                            controller.register();
                          }
                        },
                        child: Text(LocaleKeys.signup.tr)),
                  ),
                  SizedBox(
                    height: kSpacing,
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Text(
                        LocaleKeys.have_account.tr,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.offAllNamed(Routes.LOGIN_USER);
                        },
                        child: Text(
                          LocaleKeys.login.tr,
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
        );
      }),
    );
  }
}
