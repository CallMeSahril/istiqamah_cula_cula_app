import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:istiqamah_cula_cula_app/app/data/address/controller/address_controller.dart';
import 'package:istiqamah_cula_cula_app/app/data/address/entities/address_entities.dart';
import 'package:istiqamah_cula_cula_app/app/data/rajaongkir/controller/rajaongkir_controller.dart';
import 'package:istiqamah_cula_cula_app/app/data/rajaongkir/entities/city.dart';
import 'package:istiqamah_cula_cula_app/app/data/rajaongkir/entities/province.dart';

class TambahAlamatPage extends StatefulWidget {
  final AddressEntities? existingAddress;

  const TambahAlamatPage({super.key, this.existingAddress});

  @override
  State<TambahAlamatPage> createState() => _TambahAlamatPageState();
}

class _TambahAlamatPageState extends State<TambahAlamatPage> {
  final AddressController addressController = Get.find<AddressController>();
  final RajaOngkirController rajaOngkirController =
      Get.put(RajaOngkirController());
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressControllerText = TextEditingController();

  Province? selectedProvince;
  City? selectedCity;

  @override
  void initState() {
    super.initState();
    rajaOngkirController.fetchProvinces().then((_) {
      if (widget.existingAddress != null) {
        nameController.text = widget.existingAddress!.name ?? '';
        phoneController.text = widget.existingAddress!.phone ?? '';
        addressControllerText.text = widget.existingAddress!.address ?? '';

        selectedProvince = rajaOngkirController.provinces.firstWhereOrNull(
            (prov) =>
                prov.provinceId ==
                widget.existingAddress!.provinceId?.toString());

        if (selectedProvince != null) {
          rajaOngkirController
              .fetchCities(int.parse(selectedProvince!.provinceId))
              .then((_) {
            selectedCity = rajaOngkirController.cities.firstWhereOrNull(
                (city) =>
                    city.cityId == widget.existingAddress!.cityId?.toString());
            setState(() {});
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isEditMode = widget.existingAddress != null;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xffFF2B2A),
        title: Text(isEditMode ? "Edit Alamat" : "Tambah Alamat"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Nama Penerima"),
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
              ),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(labelText: "Nomor Telepon"),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
              ),
              TextFormField(
                controller: addressControllerText,
                decoration: InputDecoration(labelText: "Alamat Lengkap"),
                maxLines: 3,
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
              ),
              Obx(() => DropdownButtonFormField<Province>(
                    decoration: InputDecoration(labelText: "Pilih Provinsi"),
                    value: selectedProvince,
                    items: rajaOngkirController.provinces
                        .map((province) => DropdownMenuItem(
                              value: province,
                              child: Text(province.province),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedProvince = value;
                        selectedCity = null;
                        rajaOngkirController
                            .fetchCities(int.parse(value!.provinceId));
                      });
                    },
                    validator: (value) =>
                        value == null ? 'Wajib pilih provinsi' : null,
                  )),
              Obx(() => DropdownButtonFormField<City>(
                    decoration: InputDecoration(labelText: "Pilih Kota"),
                    value: selectedCity,
                    items: rajaOngkirController.cities
                        .map((city) => DropdownMenuItem(
                              value: city,
                              child: Text("${city.type} ${city.cityName}"),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCity = value;
                      });
                    },
                    validator: (value) =>
                        value == null ? 'Wajib pilih kota' : null,
                  )),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final address = AddressEntities(
                      name: nameController.text,
                      phone: phoneController.text,
                      address: addressControllerText.text,
                      city: selectedCity?.cityName,
                      province: selectedProvince?.province,
                      cityId: int.tryParse(selectedCity?.cityId ?? '0'),
                      provinceId:
                          int.tryParse(selectedProvince?.provinceId ?? '0'),
                    );

                    final success = isEditMode
                        ? await addressController.updateAddress(
                            widget.existingAddress!.id!, address)
                        : await addressController.addAddress(address);

                    if (success) {
                      addressController.fetchAddresses();
                      Get.back(result: address);
                      Get.snackbar(
                          "Sukses",
                          isEditMode
                              ? "Alamat berhasil diperbarui"
                              : "Alamat berhasil ditambahkan");
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffFF2B2A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(isEditMode ? "Perbarui Alamat" : "Simpan Alamat"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
