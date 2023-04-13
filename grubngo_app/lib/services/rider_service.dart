import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/riderinfo_model.dart';

class RiderServices {
  CollectionReference _collection =
      FirebaseFirestore.instance.collection('rider');

  Future<List<Rider>> getRiders() async {
    QuerySnapshot snapshot = await _collection.get();

    AllRiders riders = AllRiders.fromSnapshot(snapshot);
    return riders.riders;
  }

  Future<List<Rider>> getRidersByEmail(String email) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('rider')
        .where('email', isEqualTo: email.toLowerCase().toString())
        .get();

    AllRiders riders = AllRiders.fromSnapshot(snapshot);
    return riders.riders;
  }

  void addRider(String FirstName, LastName, Gender, TelNo, email, idCard,
      imageQR, bool status, String confirmImage) async {
    FirebaseFirestore.instance.collection('rider').add({
      // 'imagerider': imagerider,
      'FirstName': FirstName,
      'LastName': LastName,
      'Gender': Gender,
      'TelNo': TelNo,
      'email': email,
      'password': '',
      'idCard': idCard,
      'imageQR': imageQR,
      'status': status,
      'confirmImage': confirmImage,
      'role': "rider",
    });
  }

  void update(Rider item) async {
    await _collection.doc(item.id).update({
      // 'imagerider': item.imagerider,
      'FirstName': item.FirstName,
      'LastName': item.LastName,
      'Gender': item.Gender,
      'TelNo': item.TelNo,
      'email': item.email,
      'imageQR': item.imageQR,
      'status': item.status,
    });
  }
}
