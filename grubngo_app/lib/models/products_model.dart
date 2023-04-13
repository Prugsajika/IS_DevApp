import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  late String id;
  late String name;
  late String description;
  late double price;
  late String imageUrl;
  late int stock;
  late DateTime availableFromDate;
  late TimeOfDay availableFromTime;
  late DateTime availableUntilDate;
  late TimeOfDay availableUntilTime;
  late String deliveryLocation;
  late double deliveryFee;
  bool includeFeeInPrice;
  late DateTime sentDate;
  late TimeOfDay sentTime;
  late String typeOfFood;
  bool productStatus;

  Product(
      this.id,
      this.imageUrl,
      this.name,
      this.description,
      this.price,
      this.productStatus,
      this.typeOfFood,
      this.deliveryFee,
      this.includeFeeInPrice,
      this.availableFromDate,
      this.deliveryLocation,
      this.availableFromTime,
      this.sentDate,
      this.sentTime,
      this.availableUntilDate,
      this.availableUntilTime,
      this.stock);

  factory Product.fromJason(Map<String, dynamic> json) {
    return Product(
      json['id'] as String,
      json['imageUrl'] as String,
      json['name'] as String,
      json['description'] as String,
      json['price'] as double,
      json['productStatus'] as bool,
      json['typeOfFood'] as String,
      json['deliveryFee'] as double,
      json['includeFeeInPrice'] as bool,
      json['availableFromDate'] as DateTime,
      json['deliveryLocation'] as String,
      json['availableFromTime'] as TimeOfDay,
      json['sentDate'] as DateTime,
      json['sentTime'] as TimeOfDay,
      json['availableUntilDate'] as DateTime,
      json['availableUntilTime'] as TimeOfDay,
      json['stock'] as int,
    );
  }
}

class AllProducts {
  final List<Product> products;

  AllProducts(this.products);
  factory AllProducts.fromJson(QuerySnapshot s) {
    List<Product> products = s.docs.map((DocumentSnapshot ds) {
      Product product = Product.fromJason(ds.data() as Map<String, dynamic>);
      product.id = ds.id;
      print(product.id);
      return product;
    }).toList();
    print(products.length);
    return AllProducts(products);
  }
}

class ProductModel extends ChangeNotifier {
  String ProductID = '';
  String ProductimagePath = '';
  String ProductName = '';
  String ProductDetail = '';
  String ProductPrice = '';
  String Qty = '';
  // String Password = '';

  get getProductID => this.ProductID;
  set setProductID(value) {
    this.ProductID = value;
    notifyListeners();
  }

  get getProductimagePath => this.ProductimagePath;
  set setProductimagePath(value) {
    this.ProductimagePath = value;
    notifyListeners();
  }

  get getProductName => this.ProductName;
  set setProductName(value) {
    this.ProductName = value;
    notifyListeners();
  }

  get getProductDetail => this.ProductDetail;
  set setProductDetail(value) {
    this.ProductDetail = value;
    notifyListeners();
  }

  get getProductPrice => this.ProductPrice;
  set setProductPrice(value) {
    this.ProductPrice = value;
    notifyListeners();
  }

  get getQty => this.Qty;
  set setQty(value) {
    this.Qty = value;
    notifyListeners();
  }

  // get getPassword => this.Password;
  // set setPassword(value) {
  //   this.Password = value;
  //   notifyListeners();
  // }
}

class ListProduct extends ChangeNotifier {
  List<Product> _listProduct = List.empty();
  List<Product> get getListProduct => this._listProduct;

  set getListProduct(List<Product> value) {
    this._listProduct = value;
    notifyListeners();
  }

  // void setListProduct(List<Product> value) {
  //   _listProduct = value;
  //   notifyListeners();
  // }
}
