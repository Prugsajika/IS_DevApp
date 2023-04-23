import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grubngo_app/models/products_model.dart';
import 'package:provider/provider.dart';

import '../models/riderinfo_model.dart';
import '../widgets/drawerappbar.dart';
import 'products_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Rider> rider = List.empty();
  final user = FirebaseAuth.instance.currentUser!;

  void initState() {
    super.initState();
    _getEmail(context);
  }

  void _getEmail(BuildContext context) async {
    // get data  MedicalDashboard
    context.read<emailProvider>().email = user.email!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Consumer<RiderModel>(builder: (context, value, child) {
            //     return Text('สวัสดี!!' ' : ${value.FirstName}');
            //   }),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  'สวัสดี!! ' + context.read<emailProvider>().email.toString()),
            ),

            // Text('สวัสดี!! XXXXXXXXX'),
            IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, '/Login');
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('ยอดขายวันนี้'),
                          Text('0.00 ฿'),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('ยอดขายเดือนนี้'),
                          Text('0.00฿'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('โอนเงินแล้ว'),
                          Text('- ราย'),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('รอโอนเงิน'),
                          Text('- ราย'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'รายการสินค้าที่ต้องจัดส่ง',
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Container(
          //     height: 450,
          //     child: GridView.builder(
          //       itemCount: 10,
          //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //         crossAxisCount: 1,
          //         childAspectRatio: (6 / 2),
          //       ),
          //     //   itemBuilder: (context, index) => Widget(),
          //     // ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
