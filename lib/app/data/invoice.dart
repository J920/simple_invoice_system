import 'package:simple_invoice_system/app/data/item.dart';

class Invoice{
  String serialNumber;
  String buyerName;
  String date;
  List<Item> itemsList;
  double totalExclVat;
  double vatAmount;
  double totalInclVat;
  int vatRate;


  Invoice({
    this.serialNumber = "",
    this.buyerName = "",
    required this.date,
    required this.itemsList,
    required this.totalExclVat,
    required this.vatAmount,
    required this.vatRate,
    required this.totalInclVat,
  });
}