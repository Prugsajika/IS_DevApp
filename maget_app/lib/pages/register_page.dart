import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/customer_controller.dart';
import '../services/customer_services.dart';
import '../widgets/drawerappbar.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  CustomerController controller = CustomerController(FirebaseServices());

  String? _Gender = null;

  final _formkey = GlobalKey<FormState>();
  late String name;
  late String lastName;
  late String telNo;
  late String id;
  late String customerId;
  late String email;
  late String password;
  late String idCard;
  late String bank;
  late bool status;
  late String Gender;

  bool _hidePassword = true;

  void _addCustomers(
      String name, lastName, Gender, password, telNo, idCard, email) async {
    controller.addCustomer(
        name, lastName, Gender, password, telNo, idCard, email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ลงทะเบียน'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 12,
            ),
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
                          name = newValue!;
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
                          lastName = newValue!;
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
                        value: _Gender,
                        items: [
                          DropdownMenuItem(
                              child: Text("ไม่ระบุเพศ"), value: "No Gender"),
                          DropdownMenuItem(
                              child: Text("หญิง"), value: "Female"),
                          DropdownMenuItem(child: Text("ชาย"), value: "Male"),
                        ],
                        onChanged: (String? newVal) {
                          setState(() {
                            Gender = newVal!;
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
                          idCard = newValue!;
                        },
                      ),
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
                          telNo = newValue!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        maxLength: 30,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'อีเมล',
                            hintText: 'อีเมล (สำหรับเข้าใช้งาน)'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณาระบุอีเมล';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          email = newValue!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        maxLength: 30,
                        obscureText: _hidePassword,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'รหัสผ่าน',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _hidePassword = false;
                              });

                              Timer.periodic(Duration(seconds: 5), ((timer) {
                                setState(() {
                                  _hidePassword = true;
                                });
                              }));
                            },
                            icon: Icon(Icons.remove_red_eye),
                          ),
                        ),
                        onChanged: ((value) => password = value),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณาใส่รหัสผ่าน';
                          }
                          if (value.length < 5 || value.length > 30) {
                            return 'รหัสผ่านต้องมีตัวอักษรหรือตัวเลขไม่น้อยกว่า 5 ตัว';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          password = newValue!;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        obscureText: _hidePassword,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'ยืนยันรหัสผ่าน',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _hidePassword = false;
                              });

                              Timer.periodic(Duration(seconds: 5), ((timer) {
                                setState(() {
                                  _hidePassword = true;
                                });
                              }));
                            },
                            icon: Icon(Icons.remove_red_eye),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณายืนยันรหัสผ่าน';
                          }
                          if (value.length < 5 || value.length > 30) {
                            return 'รหัสผ่านต้องมีตัวอักษรหรือตัวเลขไม่น้อยกว่า 5 ตัว';
                          }
                          if (value != password) {
                            return 'รหัสผ่านไม่ตรงกัน';
                          }
                          return null;
                        },
                      ),
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

                                String msg = '';
                                try {
                                  final credential = await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                    email: email,
                                    password: password,
                                  );
                                  id = '';
                                  customerId = '';
                                  status = true;
                                  _addCustomers(name, lastName, Gender,
                                      password, telNo, idCard, email);
                                  msg = 'ลงทะเบียนสำเร็จ!';

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('$msg')),
                                  );

                                  context.read<ProfileDetailModel>()
                                    ..email = email;
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'weak-password') {
                                    print('The password provided is too weak.');
                                    msg = 'The password provided is too weak.';
                                  } else if (e.code == 'email-already-in-use') {
                                    print(
                                        'The account already exists for that email.');
                                    msg =
                                        'The account already exists for that email.';
                                  }
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('$msg')),
                                  );

                                  return;
                                } catch (e) {
                                  print(e);
                                  msg = 'Error {$e.toString()}';
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('$msg')),
                                  );
                                }
                                Navigator.pop(context);
                              }
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

class ProfileDetailModel extends ChangeNotifier {
  late String customerId = '';
  late String id = '';
  String name = '';
  String lastName = '';
  String birthDay = '';
  String email = '';
  String profilePicture = '';
  String password = '';
  String idCard = '';
  String telNo = '';
  late bool status = false;

  get getId => this.id;
  set setId(value) {
    this.id = value;
    notifyListeners();
  }

  get getCustomerId => this.customerId;
  set setCustomerId(value) {
    this.customerId = value;
    notifyListeners();
  }

  get getStatus => this.status;
  set setStatus(value) {
    this.status = value;
    notifyListeners();
  }

  get getName => this.name;
  set setName(value) {
    this.name = value;
    notifyListeners();
  }

  get getLastName => this.lastName;
  set setLastName(value) {
    this.lastName = value;
    notifyListeners();
  }

  get getBirthDay => this.birthDay;
  set setbirthDay(value) {
    this.birthDay = value;
    notifyListeners();
  }

  get getEmail => this.email;
  set setEmail(value) {
    this.email = value;
    notifyListeners();
  }

  // get getProfilePicture => this.profilePicture;
  // set setProfilePicture(value) {
  //   this.profilePicture = value;
  //   notifyListeners();
  // }

  get getPassword => this.password;
  set setPassword(value) {
    this.password = value;
    notifyListeners();
  }

  get getIDCard => this.idCard;
  set setDCard(value) {
    this.idCard = value;
    notifyListeners();
  }

  get getTelNo => this.telNo;
  set setTelNo(value) {
    this.telNo = value;
    notifyListeners();
  }
}