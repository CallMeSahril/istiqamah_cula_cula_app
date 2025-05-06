import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:istiqamah_cula_cula_app/app/core/config/token.dart';
import 'package:istiqamah_cula_cula_app/app/data/auth/controller/auth_controller.dart';
import 'package:istiqamah_cula_cula_app/app/routes/app_pages.dart';
import 'package:istiqamah_cula_cula_app/app/widgets/button/custom_button.dart';
import 'package:istiqamah_cula_cula_app/app/widgets/textfield/custom_text_form_field.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailC = TextEditingController();
  final passwordC = TextEditingController();

  final authC = Get.put(AuthController());
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
              'Hai, Selamat Datang  Di Aplikasi Toko Online Istiqamah Cula-Cula👋',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 40,
            ),
            CustomTextFormField(
              title: 'Email',
              controller: emailC,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextFormField(
              title: 'Kata Sandi',
              controller: passwordC,
              obscureText: true,
            ),
            Text(
              "Lupa kata sandi?",
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 40,
            ),
            CustomButton(
              type: ButtonType.red,
              text: 'LOGIN',
              onTap: () async {
                final success = await authC.login(
                  email: emailC.text,
                  password: passwordC.text,
                );

                if (success) {
                  
                  Get.offAllNamed(Routes.HOME);
                } else {
                  Get.snackbar("Login Gagal", "Email atau kata sandi salah!");
                }
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
                Text("Belum punya akun?"),
                GestureDetector(
                    onTap: () => Get.toNamed(Routes.REGISTER),
                    child: Text("Daftar"))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
