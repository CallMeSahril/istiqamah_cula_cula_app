import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:istiqamah_cula_cula_app/app/routes/app_pages.dart';

class PesananSuksesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Berhasil"),
        backgroundColor: Color(0xffFF2B2A),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Icon(Icons.check_circle, size: 100, color: Colors.green),
            SizedBox(height: 20),
            Text(
              "Pesanan Telah Berhasil",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              "Pesanan Akan Segera Dikirim",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            Row(
              children: [
                // Expanded(
                //   child: ElevatedButton(
                //     onPressed: () {
                //       Get.offAllNamed("/pesanan");
                //     },
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Color(0xffFF2B2A),
                //       padding: EdgeInsets.symmetric(vertical: 14),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //     ),
                //     child: Text("Lacak Pesanan", style: TextStyle(color: Colors.white)),
                //   ),
                // ),
                // SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Get.offAllNamed(Routes.HOME);
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Color(0xffFF2B2A)),
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text("Kembali Ke Beranda", style: TextStyle(color: Color(0xffFF2B2A))),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
