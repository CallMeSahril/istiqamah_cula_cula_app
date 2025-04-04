import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => controller.pages[controller.selectedIndex.value]),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
              currentIndex: controller.selectedIndex.value,
              onTap: controller.changeIndex,
                type: BottomNavigationBarType.fixed,
              selectedItemColor: Color(0xffF90C0C),
              unselectedItemColor: Color(0xffFE9564),
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: "Beranda"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search), label: "Pencarian"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.notifications), label: "Pemberitahuan"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "Profile"),
              ]),
        ));
  }
}
