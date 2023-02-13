import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hamrokhata/Screens/auth/login/login.dart';
import 'package:hamrokhata/commons/resources/app_theme.dart';
import 'package:hamrokhata/commons/routes/app_pages.dart';
import 'package:hamrokhata/commons/utils/constants.dart';
import 'package:hamrokhata/test.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: kAppName,
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      themeMode: ThemeMode.light,
      theme: AppThemes.lightThemeData,
      darkTheme: AppThemes.darkThemeData,
      initialRoute: Routes.splash,
      getPages: AppPages.routes,
    );
  }
}
