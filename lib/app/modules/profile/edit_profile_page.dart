import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:istiqamah_cula_cula_app/app/data/auth/controller/auth_controller.dart';
import 'package:istiqamah_cula_cula_app/app/routes/app_pages.dart';
import 'package:istiqamah_cula_cula_app/app/widgets/button/custom_button.dart';
import 'package:istiqamah_cula_cula_app/app/widgets/textfield/custom_text_form_field.dart';

class EditProfilePage extends StatefulWidget {
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final AuthController authController = Get.find();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  File? selectedImage;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final profile = await authController.getProfile();
    nameController.text = profile.name ?? '';
    emailController.text = profile.email ?? '';
    phoneController.text = profile.phone ?? '';
    if (profile.image != null && profile.image!.isNotEmpty) {
      await loadImageFromUrl(profile.image!);
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> loadImageFromUrl(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        final tempDir = await getTemporaryDirectory();
        final file = File(
            '${tempDir.path}/profile_${DateTime.now().millisecondsSinceEpoch}.jpg');
        await file.writeAsBytes(response.bodyBytes);
        setState(() {
          selectedImage = file;
        });
      }
    } catch (e) {
      print("Gagal mengambil gambar: $e");
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        selectedImage = File(picked.path);
      });
    }
  }

  Future<void> submit() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        selectedImage == null) {
      Get.snackbar("Error", "Semua field dan gambar wajib diisi.");
      return;
    }

    final success = await authController.updateProfile(
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
      password: passwordController.text ?? "tes123",
      image: selectedImage,
    );

    if (success) {
      if (selectedImage != null && await selectedImage!.exists()) {
        await selectedImage!.delete();
      }
      Get.snackbar("Sukses", "Profil berhasil diperbarui");
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.snackbar("Gagal", "Gagal memperbarui profil");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: Color(0xffFF2B2A),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: selectedImage != null
                        ? FileImage(selectedImage!)
                        : const AssetImage('assets/images/user_placeholder.png')
                            as ImageProvider,
                  ),
                ),
                GestureDetector(
                  onTap: pickImage,
                  child: const Center(
                    child: Text(
                      "Ubah Foto",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  title: "Nama",
                  controller: nameController,
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  title: "Email",
                  controller: emailController,
                  readOnly: true,
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  title: "Nomor HP",
                  controller: phoneController,
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  title: "Password",
                  controller: passwordController,
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: "Simpan Perubahan",
                  type: ButtonType.red,
                  onTap: submit,
                ),
              ],
            ),
    );
  }
}
