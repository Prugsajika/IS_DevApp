import 'package:flutter/material.dart';

class Product {
  final String? image, title, description;
  final int? price;
  Product({
    this.image,
    this.title,
    this.description,
    this.price,
  });
}

List<Product> product = [
  Product(
      image: 'assets/images/Grilled.jpg',
      title: 'หมูปิ้งเจ้มอย',
      description: 'dummyText',
      price: 20)
];
