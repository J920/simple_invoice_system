import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/themes/app_theme.dart';
import 'generated/locales.g.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp(),);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translationsKeys: AppTranslation.translations,
      debugShowCheckedModeBanner: false,
      locale: Get.deviceLocale,
      textDirection: TextDirection.rtl,
      title: "Application",
      theme: AppTheme.basic,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}

