import 'package:get/get_rx/src/rx_types/rx_types.dart';

class Item{
  String description;
  int availableQuantity;
  RxInt quantity;
  double price;
  double vatRate;
  double vatAmount;
  double totalExclVat;
  double total;

  Item({
    required this.description,
    required this.availableQuantity,
    required this.quantity,
    required this.price,
    required this.vatRate,
    required this.vatAmount,
    required this.totalExclVat,
    required this.total,
  });
}