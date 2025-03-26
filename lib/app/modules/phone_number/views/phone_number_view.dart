import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/phone_number_controller.dart';

class PhoneNumberView extends GetView<PhoneNumberController> {
  const PhoneNumberView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PhoneNumberView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PhoneNumberView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
