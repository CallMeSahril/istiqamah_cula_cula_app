import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:istiqamah_cula_cula_app/app/routes/app_pages.dart';
import 'package:istiqamah_cula_cula_app/app/widgets/button/custom_button.dart';

import '../controllers/welcome_controller.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE7E7E8),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2, // Spacer atas
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset('assets/logo/logo_istiqamah.png')),
                    Text(
                      'Istiqamah\ncula-cula',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
                Column(
                  children: [
                    CustomButton(
                      type: ButtonType.red,
                      text: 'Mulai',
                      onTap: () {
                        Get.toNamed(Routes.LOGIN);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Saya Sudah Memiliki Akun"),
                        Icon(
                          Icons.arrow_circle_right,
                          color: Colors.red,
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
