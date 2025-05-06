import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:istiqamah_cula_cula_app/app/data/rajaongkir/controller/rajaongkir_controller.dart';
import 'package:istiqamah_cula_cula_app/app/data/rajaongkir/entities/courier.dart';
import 'package:istiqamah_cula_cula_app/app/data/rajaongkir/entities/ongkir_service.dart';

class OpsiPengirimanPage extends StatefulWidget {
  final int originCityId;
  final int destinationCityId;
  final int weight;

  const OpsiPengirimanPage({
    super.key,
    required this.originCityId,
    required this.destinationCityId,
    required this.weight,
  });

  @override
  State<OpsiPengirimanPage> createState() => _OpsiPengirimanPageState();
}

class _OpsiPengirimanPageState extends State<OpsiPengirimanPage> {
  final RajaOngkirController rajaController = Get.put(RajaOngkirController());
  Courier? selectedCourier;

  @override
  void initState() {
    super.initState();
    rajaController.fetchCouriers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFF2B2A),
        title: const Text("Opsi Pengiriman"),
        centerTitle: true,
      ),
      body: Obx(() {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButtonFormField<Courier>(
                decoration: const InputDecoration(
                  labelText: "Pilih Kurir",
                  border: OutlineInputBorder(),
                ),
                value: selectedCourier,
                items: rajaController.couriers.map((courier) {
                  return DropdownMenuItem(
                    value: courier,
                    child: Text(courier.name),
                  );
                }).toList(),
                onChanged: (value) {
                  selectedCourier = value;
                  if (value != null) {
                    rajaController.fetchOngkir(
                      origin: widget.originCityId,
                      destination: widget.destinationCityId,
                      weight: widget.weight,
                      courier: value.code,
                    );
                  }
                },
              ),
            ),
            Expanded(
              child: Obx(() {
                final services = rajaController.services;
                if (services.isEmpty) {
                  return const Center(
                      child: Text("Belum ada layanan pengiriman"));
                }
                return ListView.builder(
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    final service = services[index];
                    return ListTile(
                      title:
                          Text("${service.service} - ${service.description}"),
                      subtitle: Text("Estimasi: ${service.etd} hari"),
                      trailing: Text("Rp ${service.value}"),
                      onTap: () => Get.back(result: {
                        'courier': selectedCourier,
                        'service':
                            service, // gunakan service dari loop saat ini
                      }),
                    );
                  },
                );
              }),
            ),
          ],
        );
      }),
    );
  }
}
