import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:istiqamah_cula_cula_app/app/data/notification/controller/notification_controller.dart';
import 'package:istiqamah_cula_cula_app/app/modules/cart/cart_page.dart';
import 'package:istiqamah_cula_cula_app/app/modules/history/history_page.dart';

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
          padding: const EdgeInsets.all(12),
          itemBuilder: (context, index) {
            final notif = controller.notifications[index];
            final title = notif.title?.toLowerCase() ?? '';

            // Deteksi status dari title
            String status;
            if (title.contains('diproses')) {
              status = 'pending';
            } else if (title.contains('dikemas')) {
              status = 'packing';
            } else if (title.contains('dikirim')) {
              status = 'delivering';
            } else if (title.contains('selesai')) {
              status = 'selesai';
            } else {
              status = 'pending'; // fallback
            }

            final tabIndex = _getTabIndexByStatus(status);

            return GestureDetector(
              onTap: () =>
                  Get.to(() => HistoryPage(initialStatusIndex: tabIndex)),
              child: Container(
                margin: EdgeInsets.only(bottom: 12),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.notifications_active,
                        color: Colors.red, size: 30),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notif.title ?? 'Judul Notifikasi',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 4),
                          Text(
                            notif.message ?? 'Pesanan anda sedang diproses.',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          SizedBox(height: 6),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: _statusColor(status).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              _statusLabel(status),
                              style: TextStyle(
                                color: _statusColor(status),
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  int _getTabIndexByStatus(String? status) {
    switch (status) {
      case 'pending':
        return 0;
      case 'packing':
        return 1;
      case 'delivering':
        return 2;
      case 'selesai':
        return 3;
      default:
        return 0;
    }
  }

  Color _statusColor(String? status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'packing':
        return Colors.amber;
      case 'delivering':
        return Colors.blue;
      case 'selesai':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _statusLabel(String? status) {
    switch (status) {
      case 'pending':
        return 'Diproses';
      case 'packing':
        return 'Dikemas';
      case 'delivering':
        return 'Dikirim';
      case 'selesai':
        return 'Selesai';
      default:
        return 'Status Tidak Dikenal';
    }
  }
}
