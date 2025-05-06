import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:istiqamah_cula_cula_app/app/data/address/controller/address_controller.dart';
import 'package:istiqamah_cula_cula_app/app/data/address/entities/address_entities.dart';
import 'package:istiqamah_cula_cula_app/app/data/carts/entities/carts_entities.dart';
import 'package:istiqamah_cula_cula_app/app/data/orders/controller/orders_controller.dart';
import 'package:istiqamah_cula_cula_app/app/data/orders/entities/payment_method.dart';
import 'package:istiqamah_cula_cula_app/app/data/rajaongkir/entities/courier.dart';
import 'package:istiqamah_cula_cula_app/app/data/rajaongkir/entities/ongkir_service.dart';
import 'package:istiqamah_cula_cula_app/app/modules/metode_pembayaran/metode_pembayaran_page.dart';
import 'package:istiqamah_cula_cula_app/app/modules/opsi_pengiriman/opsi_pengiriman_page.dart';
import 'package:istiqamah_cula_cula_app/app/modules/pesana_sukses/pesanan_sukses_page.dart';
import 'package:istiqamah_cula_cula_app/app/modules/pilih_alamat/pilih_alamat_page.dart';

class PembelianPage extends StatefulWidget {
  final List<CartEntities> carts;
  const PembelianPage({required this.carts});

  @override
  State<PembelianPage> createState() => _PembelianPageState();
}

class _PembelianPageState extends State<PembelianPage> {
  final addressController = Get.put(AddressController());
  final ordersController = Get.put(OrdersController());
  final formatter =
      NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  AddressEntities? selectedAddress;
  PaymentMethod? selectedPaymentMethod;
  Courier? selectedCourier;
  OngkirService? selectedService;
int get subtotal =>
    widget.carts.fold(0, (sum, item) => sum + ((item.product.price ?? 0) * item.quantity));


  int get layanan => int.tryParse(selectedPaymentMethod?.totalFee ?? '0') ?? 0;
  int get ongkir => selectedService?.value ?? 0;
  int get total => subtotal + layanan + ongkir;

  @override
  void initState() {
    super.initState();
    addressController.fetchAddresses().then((_) {
      if (addressController.addresses.isNotEmpty) {
        setState(() {
          selectedAddress = addressController.addresses.first;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pembelian"),
        backgroundColor: Color(0xffFF2B2A),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          // Alamat
          Obx(() {
            if (addressController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }

            final address = selectedAddress ??
                (addressController.addresses.isNotEmpty
                    ? addressController.addresses.first
                    : null);
            if (address == null) {
              return _noAddressWidget();
            }
            return _addressWidget(address);
          }),

          SizedBox(height: 10),

          // Daftar Produk
          ...widget.carts.map((cart) => _productItem(cart)).toList(),

          // Metode Pembayaran
          ListTile(
            title: Text("Metode Pembayaran"),
            trailing: GestureDetector(
              onTap: () async {
                final result = await Get.to(
                    () => MetodePembayaranPage(totalAmount: total));
                if (result != null && result is PaymentMethod) {
                  setState(() => selectedPaymentMethod = result);
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(selectedPaymentMethod?.paymentName ?? "Pilih >",
                      style: TextStyle(color: Colors.red)),
                  Icon(Icons.arrow_forward_ios, size: 14, color: Colors.red),
                ],
              ),
            ),
          ),

          // Opsi Pengiriman
          ListTile(
            title: Text("Opsi Pengiriman"),
            trailing:
                Text("Lihat Semua >", style: TextStyle(color: Colors.red)),
            onTap: () async {
              final result = await Get.to(() => OpsiPengirimanPage(
                  originCityId: 1, destinationCityId: 1, weight: 1));
              if (result != null) {
                setState(() {
                  selectedCourier = result['courier'];
                  selectedService = result['service'];
                });
              }
            },
          ),

          // Detail Pengiriman
          if (selectedService != null)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xffffebeb),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(selectedCourier?.name ?? '',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Text("Rp${selectedService!.value}",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text(
                      "Estimasi sampai ${selectedService!.etd} hari via ${selectedService!.service}",
                      style: TextStyle(fontSize: 12)),
                ],
              ),
            ),

          // Rincian Pembayaran
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Rincian Pembayaran",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                _buildRow("Subtotal Produk", formatter.format(subtotal)),
                _buildRow("Biaya Pengiriman", formatter.format(ongkir)),
                _buildRow("Biaya Layanan", formatter.format(layanan)),
                Divider(),
                _buildRow("Total Pembayaran", formatter.format(total),
                    isBold: true),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () async {
            if (selectedAddress == null ||
                selectedPaymentMethod == null ||
                selectedCourier == null ||
                selectedService == null) {
              Get.snackbar(
                  "Error", "Mohon lengkapi semua data sebelum memesan");
              return;
            }

            final body = {
              "cart_ids": widget.carts.map((cart) => cart.cartId).toList(),
              "method_pembayaran": selectedPaymentMethod!.paymentMethod,
              "ongkir": selectedService!.value,
              "address_id": selectedAddress!.id,
            };

            final respone = await ordersController.createOrder(body);
            if (respone) {
              Get.offAll(PesananSuksesPage());
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xffFF2B2A),
            padding: EdgeInsets.symmetric(vertical: 14),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: Text("Buat Pesanan", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  Widget _productItem(CartEntities cart) {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Image.network(cart.product.image ?? '',
              width: 80, height: 80, fit: BoxFit.cover),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cart.product.name ?? '',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(formatter.format(cart.product.price ?? 0)),
                    Text("x${cart.quantity}"),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRow(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: isBold ? TextStyle(fontWeight: FontWeight.bold) : null),
          Text(value,
              style: isBold ? TextStyle(fontWeight: FontWeight.bold) : null),
        ],
      ),
    );
  }

  Widget _noAddressWidget() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Color(0xFFDCDCDC),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text("Belum ada alamat tersimpan")),
          ElevatedButton(
            onPressed: () async {
              final result = await Get.to(() => PilihAlamatPage());
              if (result != null) {
                setState(() => selectedAddress = result);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xffFF2B2A),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: Text("Tambah Alamat", style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  Widget _addressWidget(AddressEntities address) {
    return Container(
      color: Color(0xFFDCDCDC),
      padding: EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.location_on, color: Colors.red),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: '${address.name}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 14),
                    children: [
                      TextSpan(
                        text: '  (${address.phone})',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4),
                Text("${address.phone}"),
                Text("${address.address}, ${address.city}, ${address.province}",
                    style: TextStyle(fontSize: 13)),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () async {
                      final result = await Get.to(() => PilihAlamatPage());
                      if (result != null) {
                        setState(() => selectedAddress = result);
                      }
                    },
                    child: Text("Ubah Alamat",
                        style: TextStyle(color: Color(0xffFF2B2A))),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
