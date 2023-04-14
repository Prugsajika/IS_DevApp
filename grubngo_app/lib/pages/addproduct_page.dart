import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grubngo_app/pages/products_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

import '../controllers/product_controller.dart';
import '../services/product_services.dart';
import '../widgets/drawerappbar.dart';

class AddProduct extends StatefulWidget {
  // const AddProduct({Key? key, required this.email}) : super(key: key);
  @override
  State<AddProduct> createState() => _AddProduct();
}

class _AddProduct extends State<AddProduct> {
  TextEditingController _date = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;

  final _formkey = GlobalKey<FormState>();
  String? typeOfFood;

  late String _name;
  late String _description;
  late String _sentDate;
  late String _sentTime;
  late String _typeOfFood;
  late String _email;
  late String UrlPd;
  late String _deliveryLocation;
  late int _price;
  late int _stock;
  late int _deliveryFee;
  late String _prices;
  late String _stocks;
  late String _deliveryFees;

  ProductController controller = ProductController(ProductServices());

  void _addProduct(String name, description, UrlPd, deliveryLocation, email,
      typeOfFood, sentDate, sentTime, int price, stock, deliveryFee) async {
    controller.addProduct(name, description, UrlPd, deliveryLocation, email,
        typeOfFood, sentDate, sentTime, price, stock, deliveryFee);
  }

  File? _imagePD;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGalleryPd() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imagePD = File(pickedFile.path);
        uploadFileQR();
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCameraPd() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _imagePD = File(pickedFile.path);
        uploadFileQR();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFileQR() async {
    if (_imagePD == null) return;
    final fileName = basename(_imagePD!.path);
    final destination = 'imagePD/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('imagePD/');
      await ref.putFile(_imagePD!);
      UrlPd = await ref.getDownloadURL();
      print("UrlPd*************** ${UrlPd}");
    } catch (e) {
      print('error occured');
    }
  }

  void _showPickerPd(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        imgFromGalleryPd();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCameraPd();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('เพิ่มรายการสินค้า'),
      ),
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.white,
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 6.0,
                      spreadRadius: 2.0,
                      color: Colors.grey,
                      offset: Offset(0.0, 0.0),
                    )
                  ],
                ),
                child: _imagePD != null
                    ? Image.file(
                        _imagePD!,
                        fit: BoxFit.cover,
                      )
                    : Center(child: Text('เพิ่มรูปสินค้า')),
              ),
              ElevatedButton(
                onPressed: () {
                  _showPickerPd(context);
                },
                child: Text("เพิ่มรูป"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'ชื่อสินค้า',
                    border: OutlineInputBorder(),
                    hintText: 'ชื่อสินค้า',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณาใส่ชื่อสินค้า';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _name = newValue!;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: 'ประเภทสินค้า',
                    // enabledBorder: OutlineInputBorder(),
                    border: OutlineInputBorder(),
                  ),
                  value: typeOfFood,
                  items: [
                    DropdownMenuItem(child: Text("ของคาว"), value: "ของคาว"),
                    DropdownMenuItem(child: Text("ของหวาน"), value: "ของหวาน"),
                  ],
                  onChanged: (String? newVal) {
                    setState(() {
                      _typeOfFood = newVal!;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'รายละเอียดสินค้า',
                      border: OutlineInputBorder(),
                      hintText: 'รายละเอียดสินค้า'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณาใส่รายละเอียดสินค้า';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _description = newValue!;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'ราคาสินค้า',
                      border: OutlineInputBorder(),
                      hintText: 'ราคาสินค้า'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณาใส่ราคาสินค้า';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _prices = newValue!;
                    // _price = int.parse(newValue!);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'จำนวนสินค้า',
                      border: OutlineInputBorder(),
                      hintText: 'จำนวนสินค้า'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณาใส่จำนวนสินค้า';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _stocks = newValue!;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'ค่าหิ้ว',
                      border: OutlineInputBorder(),
                      hintText: 'ค่าหิ้ว'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณาใส่ค่าหิ้ว';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _deliveryFees = newValue!;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _date,
                  decoration: InputDecoration(
                    labelText: 'วันที่จัดส่ง',
                    border: OutlineInputBorder(),
                    hintText: 'วันที่จัดส่ง',
                    suffixIcon: IconButton(
                      onPressed: () async {
                        DateTime? pickedate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101));
                        if (pickedate != null) {
                          setState(
                            () {
                              _date.text =
                                  DateFormat('dd/MM/yyyy').format(pickedate);
                            },
                          );
                        }
                      },
                      icon: Icon(Icons.calendar_today_rounded),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณาใส่วันที่จัดส่ง';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _sentDate = newValue!;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'เวลาที่จัดส่ง',
                    border: OutlineInputBorder(),
                    hintText: 'เวลาที่จัดส่ง',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณาใส่เวลาที่จัดส่ง';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _sentTime = newValue!;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: 'สถานที่จัดส่ง',
                      border: OutlineInputBorder(),
                      hintText: 'สถานที่จัดส่ง'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณาใส่รายละเอียดสถานที่จัดส่ง';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _deliveryLocation = newValue!;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          _formkey.currentState!.save();

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductsPage()));

                          _addProduct(
                              _name,
                              _description,
                              UrlPd,
                              _deliveryLocation,
                              user.email,
                              _typeOfFood,
                              _sentDate,
                              _sentTime,
                              // _price,
                              _price = int.parse(_prices),
                              _stock = int.parse(_stocks),
                              _deliveryFee = int.parse(_deliveryFees));

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Processing Save : $_name'),
                            ),
                          );
                        }
                      },
                      child: Text('สร้างรายการสินค้า'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
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
    );
  }
}
