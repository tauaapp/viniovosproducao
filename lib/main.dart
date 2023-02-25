import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'src/config/custom_colors.dart';
import 'src/pages/auth/controller/auth_controller.dart';
import 'src/pages_routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(AuthController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ViniOvos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white.withAlpha(190),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF32926F),
        ),
        appBarTheme: const AppBarTheme(
          color: customColorbarraNag,
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: PagesRoutes.splashRoute,
      getPages: AppPages.pages,
    );
  }
}
