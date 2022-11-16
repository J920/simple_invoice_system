import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simple_invoice_system/generated/locales.g.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              LocaleKeys.home.tr,
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
                onPressed: (){

                  Get.toNamed(Routes.CART);
                  // Get.locale == Locale("en")
                  // ? Get.updateLocale(Locale("ar"))
                  // : Get.updateLocale(Locale("en"));
            },
                child: Text("change local"),
            )
          ],
        ),
      ),
    );
  }
}
