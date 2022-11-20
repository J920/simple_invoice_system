import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:simple_invoice_system/app/util/vat_calculator.dart';

class Item{
  String id;
  String description;
  int stock;
  RxInt quantity;
  double price = 0;
  double basePrice;
  int vatRate;
  double vatAmount = 0;
  double totalExclVat = 0;
  double total = 0;
  final _calculator = VatCalculator();

  Item({
    required this.id,
    required this.description,
    required this.stock,
    required this.quantity,
    required this.basePrice,
    required this.vatRate,
  }){
    price = _calculator.calculateTotal(amountWithoutVat: basePrice, vatRate: vatRate);
    totalExclVat = basePrice * quantity.value;
    vatAmount = _calculator.calculateVatAmountBefore(amountWithoutVat: totalExclVat, vatRate: vatRate);
    total = _calculator.calculateTotal(amountWithoutVat: totalExclVat, vatRate: vatRate);
  }

  void updateQuantity({required int newQuantity}){
    quantity.value = newQuantity.clamp(1, stock);
    totalExclVat = basePrice * quantity.value;
    vatAmount = _calculator.calculateVatAmountBefore(amountWithoutVat: totalExclVat, vatRate: vatRate);
    total = _calculator.calculateTotal(amountWithoutVat: totalExclVat, vatRate: vatRate);

  }

  void incrementQuantity(){
    quantity.value = (quantity.value+1).clamp(1, stock);
    totalExclVat = basePrice * quantity.value;
    vatAmount = _calculator.calculateVatAmountBefore(amountWithoutVat: totalExclVat, vatRate: vatRate);
    total = _calculator.calculateTotal(amountWithoutVat: totalExclVat, vatRate: vatRate);

  }

  void decrementQuantity(){
    quantity.value = (quantity.value-1).clamp(1, stock);
    totalExclVat = basePrice * quantity.value;
    vatAmount = _calculator.calculateVatAmountBefore(amountWithoutVat: totalExclVat, vatRate: vatRate);
    total = _calculator.calculateTotal(amountWithoutVat: totalExclVat, vatRate: vatRate);

  }



}