import 'package:get/get.dart';

import '../../../network/firebase_service.dart';
import '../controllers/register_user_controller.dart';

class RegisterUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterUserController>(
      () => RegisterUserController(),
    );

    Get.put(
      FirebaseService(),
    );
  }
}
