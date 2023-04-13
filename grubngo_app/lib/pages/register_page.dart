import 'dart:async';
import 'dart:ffi';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:grubngo_app/widgets/uploadimage.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

import '../controllers/rider_controller.dart';
import '../models/riderinfo_model.dart';
import '../services/rider_service.dart';
import '../widgets/drawerappbar.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  List<Rider> rider = List.empty();
  RiderController controller = RiderController(RiderServices());
  bool isLoading = false;

  void initState() {
    super.initState();
    controller.onSync.listen((bool syncState) => setState(() {
          isLoading = syncState;
          print(isLoading);
        }));
    _getRiders();
  }

  void _getRiders() async {
    var newRiders = await controller.fetchRiders();
    setState(() => rider = newRiders);
    // context.read<ListRider>().setListRider(newRiders);
  }

  void _addRider(String FirstName, LastName, Gender, TelNo, email, idcard,
      imageQR, bool status, String confirmImage) async {
    controller.addRider(FirstName, LastName, Gender, TelNo, email, idcard,
        imageQR, status, confirmImage);
    _getRiders();
  }

  String? Gender;
  final _formkey = GlobalKey<FormState>();
  late String _FirstName;
  late String _LastName;
  late String _Gender;
  late String _TelNo;
  late String _idCard;
  late bool _status = true;

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File? _confirmImage;
  final ImagePicker _picker = ImagePicker();

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _confirmImage = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if (_confirmImage == null) return;
    final fileName = basename(_confirmImage!.path);
    final destination = 'confirmImage/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('confirmImage/');
      var aaa = await ref.putFile(_confirmImage!);
      print("value ======== ${aaa}");
      print(await ref.getDownloadURL());
    } catch (e) {
      print('error occured');
    }
  }

  void _showPickerCF(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(context).pop();

                      print("imagepath ${_confirmImage}");
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  // void _addRiders(Rider rider) {
  //   RiderController.addRider(rider);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ลงทะเบียนคนรับหิ้ว'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formkey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        maxLength: 30,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
                          labelText: 'ชื่อ',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณาใส่ชื่อ';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _FirstName = newValue!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        maxLength: 30,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
                          labelText: 'นามสกุล',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณาใส่นามสกุล';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _LastName = newValue!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: 'เพศ',
                          enabledBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
                        ),
                        value: Gender,
                        items: [
                          DropdownMenuItem(
                              child: Text("ไม่ระบุเพศ"), value: "No Gender"),
                          DropdownMenuItem(
                              child: Text("หญิง"), value: "Female"),
                          DropdownMenuItem(child: Text("ชาย"), value: "Male"),
                        ],
                        onChanged: (String? newVal) {
                          setState(() {
                            _Gender = newVal!;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        maxLength: 10,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
                          labelText: 'เบอร์โทรศัพท์มือถือ',
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณาใส่เบอร์โทรศัพท์ 10 หลัก ';
                          }
                          if (value.length < 10 || value.length > 10) {
                            return 'เบอร์โทรศัพท์ 10 หลัก';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _TelNo = newValue!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        maxLength: 13,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
                          labelText: 'เลขบัตรประชาชน',
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณาใส่เลขบัตรประชาชน 13 หลัก ';
                          }
                          if (value.length < 13 || value.length > 13) {
                            return 'เลขบัตรประชาชน 13 หลัก';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _idCard = newValue!;
                        },
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: _confirmImage != null
                                ? Image.file(
                                    _confirmImage!,
                                    fit: BoxFit.cover,
                                  )
                                : Text('ถ่ายรูปคู่กับบัตรประชาชน')),
                        SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            _showPickerCF(context);
                          },
                          child: Text("ถ่ายรูป"),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              if (_formkey.currentState!.validate()) {
                                _formkey.currentState!.save();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('ลงทะเบียนสำเร็จ'),
                                  ),
                                );
                                Navigator.pushNamed(context, '/3');
                              }
                              context.read<RiderModel>()
                                ..confirmImage = _confirmImage.toString()
                                ..FirstName = _FirstName
                                ..LastName = _LastName
                                ..Gender = _Gender
                                ..TelNo = _TelNo
                                ..status = _status
                                ..idCard = _idCard;
                            },
                            child: Text('ลงทะเบียน'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/Login');
                            },
                            child: Text('ยกเลิก'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
