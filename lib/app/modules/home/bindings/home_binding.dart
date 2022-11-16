import 'package:get/get.dart';
import 'package:simple_invoice_system/app/network/firebase_service.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.put(
       FirebaseService(),
    );
  }
}
