import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sizer/sizer.dart';
import 'package:teste_work/app/binding/home_binding/home_binding.dart';
import 'package:teste_work/app/ui/pages/breed_page/breed_page.dart';
import 'package:teste_work/app/ui/pages/home_page/home_page.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      // statusBarIconBrightness: Brightness.dark
    ),
  );
  runApp(
    Sizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialBinding: HomeBinding(),
          initialRoute: '/home',
          theme: ThemeData(
            appBarTheme: AppBarTheme(color: Colors.red, brightness: Brightness.dark),
          ),
          routes: {
            '/home': (context) => HomePage(),
            '/breed': (context) => BreedPage(),
          },
          // home: HomePage(),
        );
      },
    ),
  );
}
