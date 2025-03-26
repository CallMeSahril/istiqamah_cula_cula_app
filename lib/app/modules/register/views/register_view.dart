import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:istiqamah_cula_cula_app/app/routes/app_pages.dart';
import 'package:istiqamah_cula_cula_app/app/widgets/button/custom_button.dart';
import 'package:istiqamah_cula_cula_app/app/widgets/textfield/custom_text_form_field.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Daftarkan Akun',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'Halo, mohon lengkapi data dibawah ini untuk mendaftar akun baru!',
              style: TextStyle(),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 40,
            ),
            CustomTextFormField(
              title: 'Nama',
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextFormField(
              title: 'Email',
            ),
                SizedBox(
              height: 10,
            ),
              CustomTextFormField(
              title: 'No Telepon',
            ),
                SizedBox(
              height: 10,
            ),
              CustomTextFormField(
              title: 'Kata Sandi',
            ),
         
            SizedBox(
              height: 40,
            ),
            CustomButton(
              type: ButtonType.red,
              text: 'Sign Up',
              onTap: () {
                // Get.toNamed(Routes.LOGIN);
              },
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("ATAU"),
                ),
                Expanded(child: Divider()),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/logo/google_logo.png"),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Masuk dengan Google")
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Apakah sudah punya akun ? "),
                GestureDetector(
                    onTap: () => Get.toNamed(Routes.LOGIN),
                    child: Text("Login"))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
