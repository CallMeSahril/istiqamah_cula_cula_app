import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:istiqamah_cula_cula_app/app/data/orders/controller/orders_controller.dart';
import 'package:istiqamah_cula_cula_app/app/data/orders/entities/payment_method.dart';

class MetodePembayaranPage extends StatefulWidget {
  final int totalAmount;
  const MetodePembayaranPage({super.key, required this.totalAmount});

  @override
  State<MetodePembayaranPage> createState() => _MetodePembayaranPageState();
}

class _MetodePembayaranPageState extends State<MetodePembayaranPage> {
  final OrdersController controller = Get.put(OrdersController());
  RxInt selectedIndex = (-1).obs;

  @override
  void initState() {
    super.initState();
    controller.loadPaymentMethods(widget.totalAmount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Metode Pembayaran"),
        backgroundColor: Color(0xffFF2B2A),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.paymentMethods.isEmpty) {
          return Center(child: Text("Metode pembayaran tidak tersedia"));
        }

        return ListView.builder(
          itemCount: controller.paymentMethods.length,
          itemBuilder: (context, index) {
            PaymentMethod method = controller.paymentMethods[index];
            bool isSelected = selectedIndex.value == index;

            return GestureDetector(
              onTap: () {
                selectedIndex.value = index;
                Get.back(result: method); // Kirim kembali metode yang dipilih
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? Colors.red : Colors.grey.shade300,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: isSelected ? Colors.red.shade50 : Colors.white,
                ),
                child: Row(
                  children: [
                    Image.network(
                      method.paymentImage,
                      width: 50,
                      height: 50,
                      errorBuilder: (_, __, ___) => Icon(Icons.error),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(method.paymentName,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          // SizedBox(height: 4),
                          // Text("Biaya: Rp${method.totalFee}",
                          //     style: TextStyle(fontSize: 13)),
                        ],
                      ),
                    ),
                    if (isSelected) Icon(Icons.check_circle, color: Colors.red),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
