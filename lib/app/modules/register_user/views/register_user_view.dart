import 'package:flutter/material.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
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
      // appBar: AppBar(),
      body: Obx(() {
        return ModalProgressHUD(
          inAsyncCall: controller.formLoading.value,
          // inAsyncCall: false ,
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
                        return "الرجاء ادخال اسم صحيح";
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
                        return "الرجاء ادخال اسم صحيح";
                      }
                    },
                    onChanged: (value) {
                      controller.vatNumber = value;
                    },
                    decoration: kMainTextFieldDecoration.copyWith(
                      hintText: "الرقم الضريبي",
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
                        return "الرجاء ادخال اسم صحيح";
                      }
                    },
                    onChanged: (value) {
                      controller.address = value;
                    },
                    decoration: kMainTextFieldDecoration.copyWith(
                      hintText: "العنوان",
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
                        return "الرجاء ادخال اسم صحيح";
                      }
                    },
                    onChanged: (value) {
                      controller.email = value;
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
                        return "كلمة المرور غير متطابقة";
                      }
                    },
                    decoration: kMainTextFieldDecoration.copyWith(
                      hintText: "تأكيد كلمة المرور",
                    ),
                  ),

                  SizedBox(
                    height: kSpacing,
                  ),

                  SizedBox(
                    height: 76,
                    child: FormBuilderImagePicker(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "الرجاء رفع الشعار";
                        }
                      },
                      placeholderWidget: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("الشعار",
                              style: TextStyle(color: kGrayColor),
                              textAlign: TextAlign.center),
                        ],
                      ),
                      name: 'logo',
                      decoration: kMainTextFieldDecoration,
                      maxImages: 1,
                      onImage: (pickedImaged) {
                        controller.logo = pickedImaged.;
                      },
                    ),
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
                        "لديك حساب؟ ",
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
