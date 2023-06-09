import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Rider {
  late String Riderid;
  late String imagerider;
  late String FirstName;
  late String LastName;
  late String Gender;
  late String TelNo;
  late String email;
  late String Password;
  late String idCard;
  late String UrlQr;
  late bool status;
  late String UrlCf;
  late String role;

  Rider(
    // this.id,
    // this.imagerider,
    this.FirstName,
    this.LastName,
    this.Gender,
    this.TelNo,
    this.email,
    this.Password,
    this.idCard,
    this.UrlQr,
    this.status,
    this.UrlCf,
    this.role,
  );
  factory Rider.fromJson(Map<String, dynamic> json) {
    return Rider(
      // json['imagerider'] as String,
      json['FirstName'] as String,
      json['LastName'] as String,
      json['Gender'] as String,
      json['TelNo'] as String,
      json['email'] as String,
      json['Password'] as String,
      json['idCard'] as String,
      json['UrlQr'] as String,
      json['status'] as bool,
      json['UrlCf'] as String,
      json['role'] as String,
    );
  }
}

class AllRiders {
  final List<Rider> riders;

  AllRiders(this.riders);
  factory AllRiders.fromJson(List<dynamic> json) {
    List<Rider> riders;

    riders = json.map((index) => Rider.fromJson(index)).toList();

    return AllRiders(riders);
  }
//TODO รอถามอาจารย์
  factory AllRiders.fromSnapshot(QuerySnapshot s) {
    List<Rider> riders = s.docs.map((DocumentSnapshot ds) {
      print("documentsnapshot ${ds.data()}");
      Rider rider = Rider.fromJson(ds.data() as Map<String, dynamic>);
      rider.Riderid = ds.id;
      print("riderdocumentsnapshot ${rider.Riderid}");
      return rider;
    }).toList();

    return AllRiders(riders);
  }
}

class RiderModel extends ChangeNotifier {
  String id = '';
  // String imagerider = '';
  String FirstName = '';
  String LastName = '';
  String Gender = '';
  String TelNo = '';
  String email = '';
  String Password = '';
  late String idCard;
  String UrlQr = '';
  late bool status;
  String UrlCf = '';
  String role = '';

  // get getid => this.id;
  // set setid(value) {
  //   this.id = value;
  //   notifyListeners();
  // }

  // get getimagerider => this.imagerider;
  // set setimagerider(value) {
  //   this.imagerider = value;
  //   notifyListeners();
  // }

  get getFirstName => this.FirstName;
  set setFirstName(value) {
    this.FirstName = value;
    notifyListeners();
  }

  get getLastName => this.LastName;
  set setLastName(value) {
    this.LastName = value;
    notifyListeners();
  }

  get getGender => this.Gender;
  set setGender(value) {
    this.Gender = value;
    notifyListeners();
  }

  get getTelNo => this.TelNo;
  set setTelNo(value) {
    this.TelNo = value;
    notifyListeners();
  }

  get getemail => this.email;
  set setemail(value) {
    this.email = value;
    notifyListeners();
  }

  get getPassword => this.Password;
  set setPassword(value) {
    this.Password = value;
    notifyListeners();
  }

  get getidCard => this.idCard;
  set setidCard(value) {
    this.idCard = value;
    notifyListeners();
  }

  get getUrlQr => this.UrlQr;
  set setUrlQr(value) {
    this.UrlQr = value;
    notifyListeners();
  }

  get getstatus => this.status;
  set setstatus(value) {
    this.status = value;
    notifyListeners();
  }

  get getUrlCf => this.UrlCf;
  set setUrlCf(value) {
    this.UrlCf = value;
    notifyListeners();
  }

  get getrole => this.role;
  set setrole(value) {
    this.role = value;
    notifyListeners();
  }
}

class ListRiderModel extends ChangeNotifier {
  List<Rider> _listRider = List.empty();
  List<Rider> get getListRider => this._listRider;

  set getListRider(List<Rider> value) {
    this._listRider = value;
    notifyListeners();
  }

  // void setListRider(List<Rider> value) {
  //   _listRider = value;
  //   notifyListeners();
  // }
}
