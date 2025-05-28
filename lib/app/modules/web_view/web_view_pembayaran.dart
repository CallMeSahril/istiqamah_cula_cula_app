import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:istiqamah_cula_cula_app/app/routes/app_pages.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPembayaranPage extends StatelessWidget {
  final String url;
  final bool back;

  const WebviewPembayaranPage({
    super.key,
    required this.url,
    this.back = false,
  });

  void _handleBack(BuildContext context) {
    if (back) {
      Get.back();
    } else {
      Get.offAllNamed(Routes.HOME);
    }
  }

  @override
  Widget build(BuildContext context) {
    final webController = WebViewController();

    webController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) async {
            try {
              final content = await webController.runJavaScriptReturningResult(
                "document.body.innerText",
              );

              final cleaned =
                  content.toString().replaceAll(RegExp(r'["\\]'), '');

              if (cleaned.toLowerCase().contains("pembayaran berhasil")) {
                Get.snackbar("Sukses", "Pembayaran berhasil!");
                Future.delayed(const Duration(seconds: 1), () {
                  Get.offAllNamed(Routes.HOME);
                });
              }
            } catch (e) {
              debugPrint("Gagal membaca konten halaman: $e");
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(url));

    return WillPopScope(
      onWillPop: () async {
        _handleBack(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => _handleBack(context),
          ),
        ),
        extendBodyBehindAppBar: true,
        body: SafeArea(
          child: WebViewWidget(controller: webController),
        ),
      ),
    );
  }
}
