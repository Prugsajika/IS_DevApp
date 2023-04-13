import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return MaterialApp(
    home: Scaffold(
      drawer: Drawer(
        child: Container(
          child: ListTileTheme(
            textColor: Colors.black,
            iconColor: Colors.black,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 150.0,
                  height: 200.0,
                  margin: const EdgeInsets.only(
                    top: 50.0,
                    bottom: 64.0,
                  ),
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/Logo.png',
                  ),
                ),
                const ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                ),
                const ListTile(
                  leading: Icon(Icons.add),
                  title: Text('Add Product'),
                ),
                const ListTile(
                  leading: Icon(Icons.shopping_cart),
                  title: Text('Shopping Cart'),
                ),
                const ListTile(
                  leading: Icon(Icons.shopping_basket),
                  title: Text('Pre-Order'),
                ),
                const ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Setting'),
                ),
                const ListTile(
                  leading: Icon(Icons.power_settings_new),
                  title: Text('Log Out'),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
