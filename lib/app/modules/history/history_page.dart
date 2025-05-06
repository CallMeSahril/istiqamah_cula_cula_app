import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:istiqamah_cula_cula_app/app/data/history/controllers/history_controller.dart';
import 'package:istiqamah_cula_cula_app/app/data/orders/controller/orders_controller.dart';
import 'package:istiqamah_cula_cula_app/app/data/orders/entities/order_entities.dart';

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
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        title: Text("Order ID: ${order.id}"),
        subtitle: Text("Status: ${order.status}\nTotal: ${formatter.format(order.totalAmount)}"),
        isThreeLine: true,
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
