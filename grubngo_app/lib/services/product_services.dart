import 'package:cloud_firestore/cloud_firestore.dart';

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

  void update(Product item) async {
    print("update");
    print(item.id);
    await _collection.doc(item.id).update({
      "name": item.name,
      "description": item.description,
      "price": item.price,
      "stock": item.stock,
      "productStatus": item.productStatus,
      "deliveryLocation": item.deliveryLocation,
    });
  }

  void insert(Product item) async {
    await _collection.doc().set({
      "name": item.name,
      "description": item.description,
      "price": item.price,
      "stock": item.stock,
      "productStatus": item.productStatus,
      "deliveryLocation": item.deliveryLocation,
    });
  }
}
