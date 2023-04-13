import 'package:flutter/material.dart';

import '../widgets/drawerappbar.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        title: Text('ข้อมูลส่วนตัว'),
      ),
    );
  }
}
