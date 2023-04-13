import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/body.dart';
import 'login_page.dart';
import 'favourite_page.dart';
import 'orderhistory_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  get delegate => Navigator.defaultRouteName;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeStyle = Theme.of(context);

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
              icon: const Icon(Icons.shopping_cart_sharp),
              onPressed: () {
                showSearch(context: context, delegate: delegate);
              },
            ),
            IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, '/Login');
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),
        drawer: NavigationDrawer(),
        body: Body());
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildHeader(context),
          buildMenuItems(context),
        ],
      )),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Material(
      color: Colors.amber[100],
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => ProfilePage(),
          ));
        },
        child: Container(
          color: Colors.amber[100],
          padding: EdgeInsets.only(
            top: 24 + MediaQuery.of(context).padding.top,
            bottom: 24,
          ),
          child: Column(
            children: const [
              CircleAvatar(
                radius: 52,
                backgroundImage: NetworkImage(
                    'https://as1.ftcdn.net/v2/jpg/03/46/83/96/1000_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg'),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                'Panama Poomin',
                style: TextStyle(fontSize: 28, color: Colors.black),
              ),
              Text(
                'panama@email.com',
                style: TextStyle(fontSize: 16, color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildMenuItems(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(12),
    child: Wrap(
      runSpacing: 5,
      children: [
        ListTile(
            leading: const Icon(Icons.home_outlined),
            title: Text('หน้าหลัก'),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => HomePage(),
              ));
            }),
        ListTile(
            leading: const Icon(Icons.favorite_border),
            title: Text('รายการโปรด'),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const FavouritesPage(),
              ));
            }),
        ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: Text('ตระกร้าของฉัน'),
            onTap: () {}),
        // ListTile(
        //     leading: const Icon(Icons.add_box),
        //     title: Text('รายการสั่งซื้อ'),
        //     onTap: () {
        //     }),
        ListTile(
            leading: const Icon(Icons.receipt_rounded),
            title: Text('รายการสั่งซื้อ'),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => OrderHistory(),
              ));
            }),
        const Divider(
          color: Colors.black54,
        ),
        // ListTile(
        //     leading: const Icon(Icons.shopping_basket),
        //     title: Text('รับหิ้วอาหาร'),
        //     onTap: () {
        //       Navigator.of(context).pushReplacement(MaterialPageRoute(
        //         builder: (context) => RestaurantPage(),
        //       ));
        //     }),
        ListTile(
            leading: const Icon(Icons.settings),
            title: Text('การตั้งค่า'),
            onTap: () {}),
        ListTile(
            leading: const Icon(Icons.power_settings_new),
            title: Text('ออกจากระบบ'),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => LoginPage(),
              ));
            }),
      ],
    ),
  );
}

class CatagoryCard extends StatelessWidget {
  const CatagoryCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.press,
  }) : super(key: key);

  final String icon, title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: press,
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
      ),
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 8.0 / 4, vertical: 8.0 / 2),
        child: Column(
          children: [
            Image.asset('assets/images/FastFood.jpg'),
            const SizedBox(
              height: 50 / 2,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        ),
      ),
    );
  }
}

class MystatelessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      child: build(context),
    );
  }
}
