import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../generated/locales.g.dart';
import '../../../constants/app_constants.dart';
import '../../../widgets/CustomListTile.dart';
import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          LocaleKeys.confirm.tr, style: TextStyle(color: kPrimaryColor),),
        centerTitle: true,
      ),
      body: Obx(() {
        return ModalProgressHUD(
          inAsyncCall: controller.loading.value,
          child: Container(
            padding: EdgeInsets.all(kDefaultPadding),
            child: DefaultTextStyle(
              style: TextStyle(
                  color: kBlackColor, fontSize: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: controller.cartController.selectedItemsList
                          .map(
                            (e) =>
                            CustomListTile(
                              selectable: false,
                              leading: Column(
                                children: [
                                  Text("الكمية"),
                                  Text(e.quantity.value.toString()),
                                ],
                              ),
                              leadingFlex: 2,
                              titleFlex: 7,
                              title: Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 57.0),
                                  child: Text(
                                    "${e.description} ",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              trailing: Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: Column(
                                  children: [
                                    Text("${e.price} ريال", style: TextStyle(
                                        color: kGrayColor, fontSize: 10),),
                                    Text("${e.total} ريال"),

                                  ],
                                ),
                              ),

                            ),
                      )
                          .toList(),
                    ),
                  ),
                  Divider(color: kBlackColor,
                      endIndent: kDefaultPadding,
                      indent: kDefaultPadding),
                  Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("الإجمالي غير شامل الضريبة",
                            ),
                            Text("${controller.totalExclVat} ريال",
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("مجموع ضريبة القيمة المضافة",
                            ),
                            Text("${controller.totalVat} ريال",
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(LocaleKeys.total.tr,
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 20),),

                            Text("${controller.total} ريال",
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: kDefaultPadding *
                        2.5, top: kDefaultPadding),
                    child: Form(
                      key: controller.formKey,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value == "") {
                            return "الرجاء ادخال اسم صحيح";
                          }
                        },
                        decoration: kMainTextFieldDecoration.copyWith(
                            hintText: "اسم المشتري"
                        ),
                        onChanged: (value) => controller.buyerName = value,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
      floatingActionButton: Container(
        decoration: kContainerDecoration.copyWith(color: Colors.transparent),
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: 60,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () async {
              if (controller.formKey.currentState!.validate()) {
                controller.confirm();
                // await controller.createPDFInvoice();
              }
              // controller.confirmedDialog();
            },
            child: Text(LocaleKeys.confirm.tr),
          ),
        ),
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,
    );
  }
}
