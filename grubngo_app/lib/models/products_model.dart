import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  late String Productid;
  late String name;
  late String description;
  late int price;
  late String UrlPd;
  late int stock;
  late DateTime availableFromDate;
  late TimeOfDay availableFromTime;
  late DateTime availableUntilDate;
  late TimeOfDay availableUntilTime;
  late String deliveryLocation;
  late int deliveryFee;
  // bool includeFeeInPrice;
  late String sentDate;
  late String sentTime;
  late String typeOfFood;
  bool productStatus;
  late String email;

  Product(
      // this.id,
      this.UrlPd,
      this.name,
      this.description,
      this.price,
      this.productStatus,
      this.typeOfFood,
      this.deliveryFee,
      // this.includeFeeInPrice,
      // this.availableFromDate,
      this.deliveryLocation,
      // this.availableFromTime,
      this.sentDate,
      this.sentTime,
      // this.availableUntilDate,
      // this.availableUntilTime,
      this.stock,
      this.email);

  factory Product.fromJason(Map<String, dynamic> json) {
    return Product(
      // json['id'] as String,
      json['UrlPd'] as String,
      json['name'] as String,
      json['description'] as String,
      json['price'] as int,
      json['productStatus'] as bool,
      json['typeOfFood'] as String,
      json['deliveryFee'] as int,
      // json['includeFeeInPrice'] as bool,
      // json['availableFromDate'] as DateTime,
      json['deliveryLocation'] as String,
      // json['availableFromTime'] as TimeOfDay,
      json['sentDate'] as String,
      json['sentTime'] as String,
      // json['availableUntilDate'] as DateTime,
      // json['availableUntilTime'] as TimeOfDay,
      json['stock'] as int,
      json['email'] as String,
    );
  }
}

class AllProducts {
  final List<Product> products;

  AllProducts(this.products);
  factory AllProducts.fromJson(QuerySnapshot s) {
    List<Product> products = s.docs.map((DocumentSnapshot ds) {
      Product product = Product.fromJason(ds.data() as Map<String, dynamic>);
      product.Productid = ds.id;
      print(product.Productid);
      return product;
    }).toList();
    print(products.length);
    return AllProducts(products);
  }
}

class ProductModel extends ChangeNotifier {
  String Productid = '';
  String UrlPd = '';
  String ProductName = '';
  String ProductDetail = '';
  String ProductPrice = '';
  String Qty = '';
  // String Password = '';

  get getProductid => this.Productid;
  set setProductid(value) {
    this.Productid = value;
    notifyListeners();
  }

  get getUrlPd => this.UrlPd;
  set setUrlPd(value) {
    this.UrlPd = value;
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
