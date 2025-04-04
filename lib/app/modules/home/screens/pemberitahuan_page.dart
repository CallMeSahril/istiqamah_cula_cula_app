import 'package:flutter/material.dart';

class PemberitahuanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xffFF2B2A),
          centerTitle: true,
          title: Text(
            "Pemberitahuan",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart_outlined),
              onPressed: () {
                // Add your cart action here
              },
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) => ListTile(
            leading: Icon(
              Icons.image,
              size: 50,
            ),
            title: Text(
              "Pemberitahuan ${index + 1}",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text("Detail pemberitahuan ${index + 1}"),
            onTap: () {
              // Add your action here
            },
          ),
        ));
  }
}
