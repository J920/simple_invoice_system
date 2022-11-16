import 'package:simple_invoice_system/app/data/item.dart';

class Invoice{
  Invoice({
    required String serialNumber,
    required List<Item> itemsList,
    required double totalExclVat,
    required double vatAmount,
    required double totalInclVat,
  });
}