import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:istiqamah_cula_cula_app/app/data/orders/entities/order_entities.dart';
import 'package:istiqamah_cula_cula_app/app/modules/web_view/web_view_pembayaran.dart';

class OrderDetailPage extends StatelessWidget {
  final OrderEntities order;

  OrderDetailPage({required this.order});

  final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Detail Pesanan'),
        backgroundColor: Color(0xffFF2B2A),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Informasi Pesanan",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),
                  _infoRow("Tanggal Pesanan", _formatDate(order.createdAt)),
                  _infoRow("Status", order.status),
                  _infoRow("Order ID", order.merchantOrderId),
                  _infoRow("VA Number", order.vaNumber),
                  _infoRow("Total", formatter.format(order.totalAmount)),
                  Visibility(
                    visible: order.status == 'pending',
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => WebviewPembayaranPage(
                                  url: order.paymentUrl!,
                                  back: true,
                                ));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 14, horizontal: 32),
                            decoration: BoxDecoration(
                              color: Color(0xffFF2B2A),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red.withOpacity(0.3),
                                  offset: Offset(0, 4),
                                  blurRadius: 8,
                                )
                              ],
                            ),
                            child: Text(
                              "Lanjutkan Pembayaran",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Text("Produk Dipesan",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          if (order.items != null && order.items!.isNotEmpty)
            ...order.items!.map((item) => _buildProductCard(item)).toList()
          else
            Center(child: Text("Tidak ada produk dalam pesanan.")),
        ],
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Item item) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                item.product?.urlPhoto ?? '',
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Icon(Icons.broken_image, size: 70),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product?.name ?? 'Produk tidak ditemukan',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 4),
                  Text("Qty: ${item.quantity}"),
                  Text("Subtotal: ${formatter.format(item.subtotal ?? 0)}"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy, HH:mm').format(date);
  }
}
