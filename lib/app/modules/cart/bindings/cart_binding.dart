import 'package:get/get.dart';

import '../../../network/firebase_service.dart';
import '../controllers/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartController>(
      () => CartController(),
    );
    Get.put(
      FirebaseService(),
    );
  }
}
