import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:istiqamah_cula_cula_app/app/data/history/controllers/history_controller.dart';
import 'package:istiqamah_cula_cula_app/app/data/orders/controller/orders_controller.dart';
import 'package:istiqamah_cula_cula_app/app/data/orders/entities/order_entities.dart';
import 'package:istiqamah_cula_cula_app/app/modules/history/order_detail_page.dart';

class HistoryPage extends StatefulWidget {
  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final OrdersController ordersController = Get.put(OrdersController());
  final HistoryController historyController = Get.put(HistoryController());

  final List<Tab> tabs = [
    Tab(text: 'Pending'),
    Tab(text: 'Packing'),
    Tab(text: 'Dikirim'),
    Tab(text: 'Selesai'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _loadTabData(0);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _loadTabData(_tabController.index);
      }
    });
  }

  void _loadTabData(int index) {
    final status = ['pending', 'packing', 'delivering', 'selesai'][index];
    if (status == 'selesai') return;
    ordersController.loadOrders(status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Pesanan'),
        centerTitle: true,
        backgroundColor: Color(0xffFF2B2A),
        bottom: TabBar(
          controller: _tabController,
          tabs: tabs,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrderList('pending'),
          _buildOrderList('packing'),
          _buildOrderList('dikirim'),
          _buildHistoryList(),
        ],
      ),
    );
  }

  Widget _buildOrderList(String status) {
    return Obx(() {
      if (ordersController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      if (ordersController.orders.isEmpty) {
        return Center(child: Text("Tidak ada pesanan $status"));
      }

      return ListView.builder(
        itemCount: ordersController.orders.length,
        itemBuilder: (context, index) {
          final order = ordersController.orders[index];
          return _orderCard(order);
        },
      );
    });
  }

  Widget _orderCard(OrderEntities order) {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');
    return GestureDetector(
      onTap: () {
        Get.to(() => OrderDetailPage(order: order));
      },
      child: Card(
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Order ID: ${order.id}",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text("Status: ${order.status}",
                  style: TextStyle(color: Colors.grey[700])),
              Text("Total: ${formatter.format(order.totalAmount)}",
                  style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemCard(Item item, NumberFormat formatter) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              item.product?.image ?? '',
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Icon(Icons.broken_image, size: 60),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product?.name ?? 'Produk tidak diketahui',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text("Qty: ${item.quantity}"),
                Text("Subtotal: ${formatter.format(item.subtotal ?? 0)}"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHistoryList() {
    return FutureBuilder(
      future: historyController.fetchHistory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
          return Center(child: Text("Tidak ada riwayat selesai"));
        }

        final histories = snapshot.data as List;
        final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');

        return ListView.builder(
          itemCount: histories.length,
          itemBuilder: (context, index) {
            final item = histories[index];
            return Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                title: Text("${item.name}"),
                subtitle: Text(
                    "${item.address}\nTotal: ${formatter.format(item.totalAmount)}\nStatus: ${item.status}"),
                isThreeLine: true,
              ),
            );
          },
        );
      },
    );
  }
}
