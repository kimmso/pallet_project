import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pallet_project/src/binding/init_binding.dart';
import 'package:pallet_project/src/view/login.dart';

void main() async {
  await GetStorage.init();

  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0.0,
        ),
      ),
      home: SplashScreen(), // 스플래시 화면을 먼저 표시
      initialBinding: InitBinding(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1), () {
      Get.off(() => LoginPage());
    });

    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/splash.png', // 스플래시 이미지 경로
          fit: BoxFit.cover, // 이미지를 화면에 꽉 차게 설정
          width: double.infinity, // 가로 크기를 화면 전체로 설정
          height: double.infinity, // 세로 크기를 화면 전체로 설정
        ),
      ),
    );
  }
}
