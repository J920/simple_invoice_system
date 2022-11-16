import 'package:get/get.dart';

import '../../../data/item.dart';

class CartController extends GetxController {
  //TODO: Implement ItemsController
  final total = 0.0.obs;

  final itemsList = [
    Item(description: "منتج 1", price: 1, quantity: 1.obs,
        vatRate: 15, vatAmount: 15, totalExclVat: 100, total: 115,
        availableQuantity: 10),

 Item(description: "منتج 2", price: 1500, quantity: 1.obs,
        vatRate: 15, vatAmount: 15, totalExclVat: 100, total: 115,
        availableQuantity: 10),

 Item(description: "منتج 3", price: 1, quantity: 1.obs,
        vatRate: 15, vatAmount: 15, totalExclVat: 100, total: 115,
        availableQuantity: 10),

 Item(description: "منتج 4", price: 1, quantity: 1.obs,
        vatRate: 15, vatAmount: 15, totalExclVat: 100, total: 115,
        availableQuantity: 10),

 Item(description: "منتج 5", price: 1, quantity: 1.obs,
        vatRate: 15, vatAmount: 15, totalExclVat: 100, total: 115,
        availableQuantity: 10),


  ].obs;
  final RxList<Item> selectedItemsList = RxList<Item>();


  void calculateTotal(){
    total.value = 0;
    for (var element in selectedItemsList) {
      total.value = total.value + (element.quantity * element.price );
    }
  }
}
