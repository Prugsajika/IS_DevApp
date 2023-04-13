import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Rider {
  late String id;
  late String imagerider;
  late String FirstName;
  late String LastName;
  late String Gender;
  late String TelNo;
  late String email;
  late String Password;
  late String idCard;
  late String imageQR;
  late bool status;
  late String confirmImage;
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
    this.imageQR,
    this.status,
    this.confirmImage,
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
      json['imageQR'] as String,
      json['status'] as bool,
      json['confirmImage'] as String,
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
      rider.id = ds.id;
      print("riderdocumentsnapshot ${rider.id}");
      return rider;
    }).toList();

    return AllRiders(riders);
  }
}

class RiderModel extends ChangeNotifier {
  // String id = '';
  // String imagerider = '';
  String FirstName = '';
  String LastName = '';
  String Gender = '';
  String TelNo = '';
  String email = '';
  String Password = '';
  late String idCard;
  String imageQR = '';
  late bool status;
  String confirmImage = '';
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

  get getimageQR => this.imageQR;
  set setimageQR(value) {
    this.imageQR = value;
    notifyListeners();
  }

  get getstatus => this.status;
  set setstatus(value) {
    this.status = value;
    notifyListeners();
  }

  get getconfirmImage => this.confirmImage;
  set setconfirmImage(value) {
    this.confirmImage = value;
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
