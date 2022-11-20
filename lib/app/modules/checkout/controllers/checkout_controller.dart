import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';
import 'package:simple_invoice_system/app/data/invoice.dart';
import 'package:simple_invoice_system/generated/locales.g.dart';
import '../../../constants/app_constants.dart';
import '../../../data/item.dart';
import '../../../network/firebase_service.dart';
import '../../../routes/app_pages.dart';
import '../../cart/controllers/cart_controller.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class CheckoutController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final CartController cartController = Get.find();
  final FirebaseService _firebaseService = Get.find();
  String buyerName = "";
  double totalExclVat = 0;
  double totalVat = 0;
  double total = 0;
  final loading = false.obs;

  @override
  Future<void> onInit() async {
    calculateDetails();

  }

  calculateDetails() {
    total = cartController.total.value;

    totalVat = cartController.calculator.calculateVatAmountAfter(
        amountWithVat: total, vatRate: cartController.vatRate);

    totalExclVat = cartController.calculator.calculateTotalBeforeVat(
        amountWithVat: total, vatRate: cartController.vatRate);
  }

  confirm() async {
    loading.value = true;
    var invoice = Invoice(
        buyerName: buyerName,
        date: "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}",
        itemsList: cartController.selectedItemsList.map((item) =>
            Item(
              id: item.id,
              description: item.description,
              quantity: item.quantity,
              vatRate: item.vatRate,
              basePrice: item.basePrice,
              stock: item.stock,
            ),
        ).toList(),
        totalExclVat: totalExclVat,
        vatRate: await _firebaseService.getVatRate(),
        vatAmount: totalVat,
        totalInclVat: total,
    );
        var response = await _firebaseService.createInvoice(invoice: invoice);

    if(response.isOk) {

      var pdfInvoice = await createPDFInvoice(invoice: response.body!);
      await _firebaseService.uploadPDFInvoice(pdf: pdfInvoice, serialNumber: response.body!.serialNumber);
      loading.value = false;

      cartController.selectedItemsList.clear();
    cartController.total.value = 0 ;
    Get.back();

    Get.defaultDialog(
        title: "هل تريد طباعة الفاتورة؟",
        middleText: "",
        actions: [

          TextButton(
              onPressed: (){
               Get.back();
              },
              child: Text(LocaleKeys.cancel.tr),
          ),
          ElevatedButton(
            onPressed: (){
              Get.back();
              Get.dialog(PdfPreview(
                build: (format) =>  pdfInvoice,
              ));
            },
            child: Text(LocaleKeys.ok.tr),
          ),
        ],
    );
  }
    else {
      loading.value = false;
      GetSnackBar(
        titleText: Text(
          response.statusCode.toString(),
          style: const TextStyle(color: kPrimaryColor),
        ),
        messageText:
        Text(response.statusText ?? "حصل خطأ اثناء حفظ الفاتورة"),
        backgroundColor: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 5),
        snackStyle: SnackStyle.FLOATING,
      ).show();
    }

  }

  Future<Uint8List> createPDFInvoice({required Invoice invoice}) async{
    final font = await PdfGoogleFonts.cairoBlack();
    final logoImage = await networkImage(_firebaseService.user.logoUrl ?? "");

    final pdf = pw.Document();
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return
            pw.Directionality(
              textDirection: pw.TextDirection.rtl,
                child :pw.DefaultTextStyle(
             style: pw.TextStyle(font: font, fontSize: 12),
                child: pw.Column(
                children: [
                  pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Text(invoice.date),
                    pw.Text("التاريخ: "),
                  ],),
                  pw.SizedBox(height: kDefaultPadding),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.SizedBox(width: 100, height: 100, child: pw.BarcodeWidget(
                        color: PdfColor.fromHex("#000000"),
                        barcode: pw.Barcode.qrCode(),
                        data: "serialNumber=${invoice.serialNumber}, totalPrice=${invoice.totalInclVat}, vatRate=${invoice.vatRate}, vatAmount=${invoice.vatAmount}",
                      ),),
                      pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                        children: [
                          pw.SizedBox(width: 100, height: 100, child: pw.Image(logoImage),),

                        ],
                      )
                    ],

                  ),

                  pw.SizedBox(height: kDefaultPadding*2),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                    pw.Text(_firebaseService.user.name ?? "test"),
                    pw.Text("الإسم: "),
                  ],
                  ),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                    pw.Text(_firebaseService.user.address ?? "test"),
                    pw.Text(LocaleKeys.address.tr),
                  ],),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                    pw.Text(_firebaseService.user.vatNumber ?? "test"),
                    pw.Text("${LocaleKeys.vat_number.tr}: "),
                  ],),
                  pw.SizedBox(height: kDefaultPadding*2),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                    pw.Text(invoice.buyerName),
                    pw.Text("${LocaleKeys.buyer_name.tr}: "),
                  ],),
                  pw.SizedBox(height: kDefaultPadding),
                  pw.Table(
                      border: pw.TableBorder.all(), // Allows to add a border decoration around your table
                      defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,

                      children: getPDFTableRows(items: invoice.itemsList),

                  ),
                  pw.SizedBox(height: kDefaultPadding*2),
                  pw.Container(
                    child: pw.Column(
                      children: [
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text("${invoice.totalExclVat} ${LocaleKeys.riyal.tr}",
                            ),
                            pw.Text(LocaleKeys.total_no_vat.tr,
                            ),
                          ],
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text("${invoice.vatAmount} ${LocaleKeys.riyal.tr}",
                            ),
                            pw.Text("${LocaleKeys.total_vat_amount.tr} %${invoice.vatRate}",
                            ),
                          ],
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text("${invoice.totalInclVat} ${LocaleKeys.riyal.tr}", style: const pw.TextStyle(fontSize: 24),),
                            pw.Text(LocaleKeys.total.tr,
                              style: const pw.TextStyle(fontSize: 24),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]
            )));


          // Center
        }));

    return pdf.save();
  }

  getPDFTableRows({required List<Item> items}){

    List<pw.TableRow> rows = [];
    rows.add(
      pw.TableRow(
          verticalAlignment: pw.TableCellVerticalAlignment.middle,
          children :[
            pw.Center(child: pw.Text(LocaleKeys.grand_total.tr),),
            pw.Center(child: pw.Text(LocaleKeys.vat.tr),),
            pw.Center(child: pw.Text(LocaleKeys.vat_rate.tr),),
            pw.Center(child: pw.Text(LocaleKeys.total.tr),),
            pw.Center(child: pw.Text(LocaleKeys.quantity.tr),),
            pw.Center(child: pw.Text(LocaleKeys.price.tr),),
            pw.Center(child: pw.Text(LocaleKeys.description.tr),),
          ]),
    );

    rows.addAll(items.map
      ((element) =>
        pw.TableRow(
        verticalAlignment: pw.TableCellVerticalAlignment.middle,
        children :[
          pw.Center(child: pw.Text(element.total.toString()),),
          pw.Center(child: pw.Text(element.vatAmount.toString()),),
          pw.Center(child: pw.Text("%${element.vatRate}"),),
          pw.Center(child: pw.Text(element.totalExclVat.toString()),),
          pw.Center(child: pw.Text(element.quantity.value.toString()),),
          pw.Center(child: pw.Text(element.basePrice.toString()),),
          pw.Center(child: pw.Text(element.description),),

        ]),

    ).toList());

    return rows;
  }

}
