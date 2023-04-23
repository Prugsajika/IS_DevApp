// TODO Implement this library.import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/customer_model.dart';

class CustomerServices {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('customer');
  Future<List<Customer>> getCustomers() async {
    QuerySnapshot snapshot = await _collection.get();

    AllCustomers customers = AllCustomers.fromSnapshot(snapshot);
    return customers.customers;
  }

  Future<List<Customer>> getCustomersByEmail(String email) async {
    QuerySnapshot snapshot =
        await _collection.where('email', isEqualTo: email).get();

    AllCustomers custsnap = AllCustomers.fromSnapshot(snapshot);
    return custsnap.customers;
  }

  void add(
      String name, lastName, Gender, password, telNo, idCard, email) async {
    await _collection.add({
      'customerId': '',
      // 'id': '',
      'name': name,
      'lastName': lastName,
      'Gender': Gender,
      'telNo': telNo,
      'idCard': idCard,
      'password': '',
      'status': true,
      'role': "buyer",
      'email': email,
    }).then((value) =>
        FirebaseFirestore.instance.collection('customer').doc(value.id).update({
          // 'id': value.id,
          'customerId': value.id,
        }));
  }
}
