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

  void addRider(String FirstName, LastName, Gender, TelNo, email, idCard, UrlQr,
      bool status, String UrlCf) async {
    FirebaseFirestore.instance.collection('rider').add({
      // 'id': "",
      'FirstName': FirstName,
      'LastName': LastName,
      'Gender': Gender,
      'TelNo': TelNo,
      'email': email,
      'password': '',
      'idCard': idCard,
      'UrlQr': UrlQr,
      'status': false,
      'UrlCf': UrlCf,
      'role': "rider",
    }).then((value) =>
        FirebaseFirestore.instance.collection('rider').doc(value.id).update({
          'Riderid': value.id,
        }));
  }

  void updateAc(Rider item) async {
    print(item.Riderid);
    await _collection.doc(item.Riderid).update({
      // 'imagerider': item.imagerider,
      // 'FirstName': item.FirstName,
      // 'LastName': item.LastName,
      // 'Gender': item.Gender,
      // 'TelNo': item.TelNo,
      'email': item.email,
      'UrlQr': item.UrlQr,
      // 'status': item.status,
    });
  }
}
