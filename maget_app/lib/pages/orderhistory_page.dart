import 'package:flutter/material.dart';
import 'package:maget_app/pages/home_page.dart';

class OrderHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        title: const Text('รายการสั่งซื้อ'),
        backgroundColor: Colors.amber[100],
      ),
    );
  }
}
