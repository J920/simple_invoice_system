import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simple_invoice_system/app/modules/cart/controllers/cart_controller.dart';
import 'package:simple_invoice_system/app/routes/app_pages.dart';

import '../../../../generated/locales.g.dart';
import '../../../constants/app_constants.dart';
import '../../../widgets/CustomListTile.dart';
import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.find();

    return Container(
      decoration: kContainerDecoration,
      child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(LocaleKeys.confirm.tr, style: TextStyle(color: kPrimaryColor),),
              centerTitle: true,
            ),
            body: Container(
              padding: EdgeInsets.all(kDefaultPadding),
              child: DefaultTextStyle(
                style: TextStyle(
                    color: kBlackColor, fontSize: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Obx(() =>
                        Expanded(
                          child: ListView(
                            physics: BouncingScrollPhysics(),
                            children: cartController.selectedItemsList
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
                                    leadingFlex: 4,
                                    titleFlex: 7,
                                    title: Flexible(
                                      child: Text(
                                        "${e.description} ",
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    subTitle1: Text("الكمية المتاحة: ${e.availableQuantity}"),
                                    trailing: Text("${e.price} ريال"),

                                  ),
                            )
                                .toList(),
                          ),
                        )),
                    Divider(color: kBlackColor, endIndent: kDefaultPadding, indent: kDefaultPadding),
                    Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("الإجمالي غير شامل الضريبة",
                                // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                              ),

                              Text("\$250",
                                  // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("مجموع ضريبة القيمة المضافة",
                                // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                              ),

                              Text("\$250",
                                  // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(LocaleKeys.total.tr,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),

                              Text("\$250",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: kDefaultPadding*2.5),
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
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
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
                  onPressed: () {
                    if(controller.formKey.currentState!.validate()){
                      Get.offAllNamed(Routes.CART);
                    }
                    // controller.confirmedDialog();
                  },
                  child: Text(LocaleKeys.confirm.tr),
                ),
              ),
            ),
            floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked,
          ),

    );
  }
}
