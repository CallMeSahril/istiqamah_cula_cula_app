import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.red, // Warna status bar merah
    statusBarIconBrightness: Brightness.light, // Ikon status bar jadi putih
  ));

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Color(0xffFF2B2A), // Warna status bar
            statusBarIconBrightness: Brightness.light, // Warna ikon status bar
          ),
        ),
      ),
      getPages: AppPages.routes,
    ),
  );
}
