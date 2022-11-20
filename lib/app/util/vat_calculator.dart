import 'package:get/get.dart';

class VatCalculator{

  double calculateTotal({required double amountWithoutVat, required int vatRate}){
    return (amountWithoutVat * ( 1 + (vatRate/100) )).toPrecision(2);
  }

  double calculateVatAmountBefore({required double amountWithoutVat, required int vatRate}){
    return (amountWithoutVat * (vatRate/100)).toPrecision(2);
  }

  double calculateVatAmountAfter({required double amountWithVat, required int vatRate}){
    return (
        calculateTotalBeforeVat(amountWithVat: amountWithVat, vatRate: vatRate)
            * (vatRate/100)
    ).toPrecision(2);
  }

  double calculateTotalBeforeVat({required double amountWithVat, required int vatRate}){
    return (amountWithVat / ( 1 + (vatRate/100) )).toPrecision(2);
  }

}