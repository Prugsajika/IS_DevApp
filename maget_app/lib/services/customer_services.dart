// TODO Implement this library.import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/customer_model.dart';

class FirebaseServices {
  Future<List<Customer>> getCustomers() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('customer').get();

    AllCustomers customers = AllCustomers.fromSnapshot(snapshot);
    return customers.customers;
  }

  Future<List<Customer>> getCustomersByEmail(String email) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('customer')
        .where('email', isEqualTo: email.toLowerCase().toString())
        .get();

    AllCustomers customers = AllCustomers.fromSnapshot(snapshot);
    return customers.customers;
  }

  void add(
      String name, lastName, Gender, password, telNo, idCard, email) async {
    FirebaseFirestore.instance.collection('customer').add({
      'customerId': '',
      'id': '',
      'name': name,
      'lastName': lastName,
      'Gender': Gender,
      'telNo': telNo,
      'idCard': idCard,
      'password': '',
      'status': true,
      'role': "buyer",
      'email': email.toLowerCase().toString(),
    }).then((value) =>
        FirebaseFirestore.instance.collection('customer').doc(value.id).update({
          'id': value.id,
          'customerId': value.id,
        }));
  }
}
