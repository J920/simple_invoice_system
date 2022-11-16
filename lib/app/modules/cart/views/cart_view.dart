import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simple_invoice_system/app/routes/app_pages.dart';
import 'package:simple_invoice_system/app/widgets/CustomListTile.dart';
import 'package:simple_invoice_system/generated/locales.g.dart';

import '../../../constants/app_constants.dart';
import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: ListView.builder(

            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(kDefaultPadding),
            itemCount: controller.itemsList.length,
            itemBuilder: (context, index) {
              var item = controller.itemsList[index];
              return Obx(() {
                return CustomListTile(
                  onPress: () {
                    controller.selectedItemsList.contains(item)
                        ? controller.selectedItemsList.remove(item)
                        : controller.selectedItemsList.add(item);
                    controller.calculateTotal();
                  },
                  selected: controller.selectedItemsList.contains(item),
                  leading: Row(
                    children: [
                      IconButton(onPressed: () {
                        item.quantity.value = (item.quantity.value + 1).clamp(
                            1, item.availableQuantity).toInt();
                        controller.calculateTotal();
                      },
                          icon: Icon(Icons.add)),
                      Text(item.quantity.value.toString()),
                      IconButton(onPressed: () {
                        item.quantity.value = (item.quantity.value - 1).clamp(
                            1, item.availableQuantity).toInt();
                        controller.calculateTotal();
                      },
                          icon: Icon(Icons.remove)),
                    ],
                  ),
                  leadingFlex: 4,
                  titleFlex: 7,
                  title: Flexible(
                    child: Text(
                      "${item.description} ",
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  subTitle1: Text("الكمية المتاحة: ${item.availableQuantity}"),
                  trailing: Text("${item.price} ريال"),
                );
              });
            }
        ),
      ),
      floatingActionButton:
      Obx(() {
        return Row(
          children: [

            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Text("${LocaleKeys.total.tr} ${controller.total.value}"),
            ),
            if(controller.selectedItemsList.isNotEmpty) Expanded(
              child: ElevatedButton(

                onPressed: () {
                  Get.toNamed(Routes.CHECKOUT);
                },
                child: Text(LocaleKeys.next.tr),
              ),
            ),
          ],
        );
      }),
    );
  }
}
