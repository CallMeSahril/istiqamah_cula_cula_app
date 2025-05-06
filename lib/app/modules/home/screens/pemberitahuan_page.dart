import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:istiqamah_cula_cula_app/app/data/notification/controller/notification_controller.dart';
import 'package:istiqamah_cula_cula_app/app/modules/cart/cart_page.dart';

class PemberitahuanPage extends StatefulWidget {
  const PemberitahuanPage({super.key});

  @override
  State<PemberitahuanPage> createState() => _PemberitahuanPageState();
}

class _PemberitahuanPageState extends State<PemberitahuanPage> {
  final NotificationController controller = Get.put(NotificationController());

  @override
  void initState() {
    super.initState();
    controller.fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xffFF2B2A),
        centerTitle: true,
        title: Text(
          "Pemberitahuan",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined),
            onPressed: () {
               Get.to(CartPage());
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.notifications.isEmpty) {
          return Center(child: Text("Belum ada pemberitahuan"));
        }

        return ListView.builder(
          itemCount: controller.notifications.length,
          itemBuilder: (context, index) {
            final notif = controller.notifications[index];
            return ListTile(
              leading: Icon(Icons.notifications, size: 40, color: Colors.red),
              title: Text(
                notif.title ?? 'Judul',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text(notif.message ?? 'Isi notifikasi'),
              onTap: () {
                // Tambahkan aksi jika perlu
              },
            );
          },
        );
      }),
    );
  }
}
