import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:istiqamah_cula_cula_app/app/modules/history/history_page.dart';
import 'package:istiqamah_cula_cula_app/app/modules/home/screens/beranda_page.dart';
import 'package:istiqamah_cula_cula_app/app/modules/home/screens/pemberitahuan_page.dart';
import 'package:istiqamah_cula_cula_app/app/modules/home/screens/pencarian_page.dart';
import 'package:istiqamah_cula_cula_app/app/modules/home/screens/profile_page.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  final List<Widget> pages = [
    BerandaPage(),
    PencarianPage(),
    PemberitahuanPage(),
    ProfilePage(),
  ];
}
