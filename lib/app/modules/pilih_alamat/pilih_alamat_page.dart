import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:istiqamah_cula_cula_app/app/data/address/controller/address_controller.dart';
import 'package:istiqamah_cula_cula_app/app/modules/tambah_alamat/tambah_alamat_page.dart';

class PilihAlamatPage extends StatefulWidget {
  const PilihAlamatPage({super.key});

  @override
  State<PilihAlamatPage> createState() => _PilihAlamatPageState();
}

class _PilihAlamatPageState extends State<PilihAlamatPage> {
  final AddressController addressController = Get.put(AddressController());
  RxInt selectedIndex = 0.obs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      addressController.fetchAddresses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xffFF2B2A),
        title: Text("Pilih Alamat"),
        centerTitle: true,
      ),
      body: Obx(() {
        if (addressController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        final addresses = addressController.addresses;
        if (addresses.isEmpty) {
          return Center(child: Text("Belum ada alamat"));
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                "Pilih atau tambahkan alamat pengiriman",
                style: TextStyle(fontSize: 14),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  final item = addresses[index];
                  final isSelected = selectedIndex.value == index;
                  return Obx(() => Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            )
                          ],
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      text: '${item.name ?? ""}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15),
                                      children: [
                                        TextSpan(
                                          text:
                                              '  - ${index == 0 ? "Utama" : "Opsi"}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Radio(
                                  value: index,
                                  groupValue: selectedIndex.value,
                                  onChanged: (value) {
                                    selectedIndex.value = value as int;
                                    Get.back(
                                        result: addresses[
                                            value]); // Kembalikan alamat yang dipilih
                                  },
                                  activeColor: Color(0xffFF2B2A),
                                )
                              ],
                            ),
                            SizedBox(height: 4),
                            Text("${item.phone}"),
                            Text(
                              "${item.address}, ${item.city}, ${item.province},",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 13,
                                height: 1.4,
                              ),
                            ),
                            SizedBox(height: 10),
                            Divider(color: Color(0xffFF2B2A)),
                            Align(
                              alignment: Alignment.center,
                              child: TextButton(
                                onPressed: () {
                                  Get.to(TambahAlamatPage(
                                    existingAddress: item,
                                  ));
                                },
                                child: Text("Edit",
                                    style: TextStyle(color: Color(0xffFF2B2A))),
                              ),
                            ),
                          ],
                        ),
                      ));
                },
              ),
            ),
            SizedBox(height: 8),
          ],
        );
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: OutlinedButton(
          onPressed: () {
            Get.to(TambahAlamatPage());
          },
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Color(0xffFF2B2A)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text("Tambah Alamat Baru",
              style: TextStyle(color: Color(0xffFF2B2A))),
        ),
      ),
    );
  }
}
