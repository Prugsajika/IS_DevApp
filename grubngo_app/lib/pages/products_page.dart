import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grubngo_app/pages/detailproduct_page.dart';

import '../widgets/drawerappbar.dart';

class ProductsPage extends StatefulWidget {
  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final user = FirebaseAuth.instance.currentUser!;
  String searchvalue = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        title: Text('สินค้า'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshots) {
          return (snapshots.connectionState == ConnectionState.waiting)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: snapshots.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshots.data!.docs[index].data()
                        as Map<String, dynamic>;

                    if (searchvalue.isEmpty) {
                      return ListTile(
                        shape: RoundedRectangleBorder(
                          //<-- SEE HERE
                          side: BorderSide(width: 1, color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        title: Text(
                          data['name'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          data['description'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(data['UrlPd']),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          //detail product page//
                          // _dreamDetail = data['detail'];
                          // _dreamName = data['name'];
                          // _dreamResult = data['result'];
                          // _dreamImage = data['image'];
                          // context.read<MyDreamNewProfileModel>()
                          //   ..dreamdetail = _dreamDetail
                          //   ..dreamname = _dreamName
                          //   ..dreamresult = _dreamResult
                          //   ..dreamimage = _dreamImage;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailProductPage(),
                            ),
                          );
                        },
                      );
                    }
                    if (data['name']
                        .toString()
                        .toLowerCase()
                        .startsWith(searchvalue.toLowerCase())) {
                      return ListTile(
                        shape: RoundedRectangleBorder(
                          //<-- SEE HERE
                          side: BorderSide(width: 1, color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        title: Text(
                          data['name'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          data['description'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(data['UrlPd']),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          // _dreamDetail = data['details'];
                          // _dreamName = data['name'];
                          // _dreamResult = data['result'];
                          // _dreamImage = data['image'];
                          // context.read<MyDreamNewProfileModel>()
                          //   ..dreamdetail = _dreamDetail
                          //   ..dreamname = _dreamName
                          //   ..dreamresult = _dreamResult
                          //   ..dreamimage = _dreamImage;
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => MyDreamNewProfilePage(
                          //       profile: MyDreamNewProfile(
                          //         _dreamDetail,
                          //         _dreamName,
                          //         _dreamResult,
                          //         _dreamImage,
                          //       ),
                          //     ),
                          //   ),
                          // );
                        },
                      );
                    }
                    return Container();
                  });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/5');
        },
        backgroundColor: Colors.red[500],
        child: const Icon(Icons.add),
      ),
    );
  }
}


//disable some listview buider by status in product model