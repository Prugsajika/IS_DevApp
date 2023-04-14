import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grubngo_app/pages/addproduct_page.dart';

import '../models/products_model.dart';

class ProductServices {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('products');

  Future<List<Product>> get() async {
    QuerySnapshot snapshot = await _collection.get();

    AllProducts snap = AllProducts.fromJson(snapshot);

    print(snap.products.length);
    return snap.products;
  }

  void addProduct(String name, description, UrlPd, deliveryLocation, email,
      typeOfFood, sentDate, sentTime, int price, stock, deliveryFee) async {
    FirebaseFirestore.instance.collection('products').add({
      // 'id': "",
      'name': name,
      'description': description,
      'UrlPd': UrlPd,
      'deliveryLocation': deliveryLocation,
      'email': email,
      'typeOfFood': typeOfFood,
      'sentDate': sentDate,
      'sentTime': sentTime,
      'price': price,
      'stock': stock,
      'deliveryFee': deliveryFee,
      'productStatus': true,
    }).then((value) =>
        FirebaseFirestore.instance.collection('products').doc(value.id).update({
          'Productid': value.id,
        }));
  }

  // void update(Product item) async {
  //   print("update");
  //   print(item.id);
  //   await _collection.doc(item.id).update({
  //     "name": item.name,
  //     "description": item.description,
  //     "price": item.price,
  //     "stock": item.stock,
  //     "productStatus": item.productStatus,
  //     "deliveryLocation": item.deliveryLocation,
  //   });
  // }

  // void insert(Product item) async {
  //   await _collection.doc().set({
  //     "name": item.name,
  //     "description": item.description,
  //     "price": item.price,
  //     "stock": item.stock,
  //     "productStatus": item.productStatus,
  //     "deliveryLocation": item.deliveryLocation,
  //   });
  // }
}
