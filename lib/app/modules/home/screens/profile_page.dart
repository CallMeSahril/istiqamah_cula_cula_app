import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:istiqamah_cula_cula_app/app/widgets/button/custom_button.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xffFF2B2A),
          centerTitle: true,
          title: Text(
            "Pemberitahuan",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart_outlined),
              onPressed: () {
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
                      Icon(Icons.image, size: 50),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "UNKNOWN",
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
                  // Add your action here
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
                  // Add your action here
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
                  // Add your action here
                },
                text: "Keluar",
              ),
            
            ],
          ),
        ));
  }
}
