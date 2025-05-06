import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:istiqamah_cula_cula_app/app/core/config/token.dart';
import 'package:istiqamah_cula_cula_app/app/data/auth/controller/auth_controller.dart';
import 'package:istiqamah_cula_cula_app/app/data/auth/model/profile_model.dart';
import 'package:istiqamah_cula_cula_app/app/modules/cart/cart_page.dart';
import 'package:istiqamah_cula_cula_app/app/modules/history/history_page.dart';
import 'package:istiqamah_cula_cula_app/app/modules/pilih_alamat/pilih_alamat_page.dart';
import 'package:istiqamah_cula_cula_app/app/routes/app_pages.dart';
import 'package:istiqamah_cula_cula_app/app/widgets/button/custom_button.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthController _authController = Get.put(AuthController());

  ProfileEntities profile = ProfileEntities(); // Default kosong
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  void fetchProfile() async {
    final result = await _authController.getProfile();
    if (!mounted) return;
    setState(() {
      profile = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xffFF2B2A),
          centerTitle: true,
          title: Text(
            "Profile",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart_outlined),
              onPressed: () {
                Get.to(CartPage());
                // Add your cart action here
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(25),
                          // image: DecorationImage(image: )
                        ),
                        child:
                            Icon(Icons.person, size: 30, color: Colors.white),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          profile.name?.toUpperCase() ?? 'UNKNOWN',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Icon(Icons.notifications_none, size: 30),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading: Icon(
                  Icons.lock,
                  size: 24,
                ),
                title: Text(
                  "Ubah Kata Sandi",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
                onTap: () {
                  // Add your action here
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.place,
                  size: 24,
                ),
                title: Text(
                  "Alamat Saya",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
                onTap: () {
                  Get.to(() => PilihAlamatPage());
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.shopping_bag,
                  size: 24,
                ),
                title: Text(
                  "Pesanan Saya",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
                onTap: () {
                  Get.to(
                    HistoryPage(),
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.safety_check_rounded,
                  size: 24,
                ),
                title: Text(
                  "Kebijakan Privasi",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),
                onTap: () {
                  // Add your action here
                },
              ),
              SizedBox(
                height: context.height * 0.3,
              ),
              CustomButton(
                type: ButtonType.red,
                onTap: () {
                  AuthHelper.deleteToken();
                  Get.offAllNamed(Routes.WELCOME);
                },
                text: "Keluar",
              ),
            ],
          ),
        ));
  }
}
