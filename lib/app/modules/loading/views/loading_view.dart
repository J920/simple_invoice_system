import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import '../../../network/firebase_service.dart';
import '../../../routes/app_pages.dart';


final FirebaseService _firebaseService = Get.put(FirebaseService());

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if(_firebaseService.isLoggedIn()) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Get.offAllNamed(Routes.CART);
      });

    }else {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Get.offAllNamed(Routes.LOGIN_USER);
      });

    }

    return Scaffold(body: Center(child: RefreshProgressIndicator()));
  }
}
