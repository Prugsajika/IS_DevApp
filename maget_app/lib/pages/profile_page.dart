import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:maget_app/pages/home_page.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_city),
            Text(
              "15/2 Bangkok",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      drawer: NavigationDrawer(),
    );
  }
}
