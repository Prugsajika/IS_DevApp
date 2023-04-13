import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../widgets/drawerappbar.dart';

class AddProduct extends StatefulWidget {
  // const AddProduct({Key? key, required this.email}) : super(key: key);
  @override
  State<AddProduct> createState() => _AddProduct();
}

class _AddProduct extends State<AddProduct> {
  TextEditingController _date = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  late String _productName;
  late String _productDetail;
  late String _deliveryDate;
  late String _deliveryTime;
  late String _catagoryFood;

  bool _hidePassword = true;

  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
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
              Card(
                child: Container(
                  width: 500,
                  height: 200,
                  child: image != null
                      ? Image.file(image!)
                      : Text('เพิ่มรูปสินค้า'),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  pickImageC();
                },
                child: Text("ถ่ายรูป"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
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
                    _productName = newValue!;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'ประเภทสินค้า',
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_drop_down_sharp),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณาใส่ประเภทสินค้า';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _catagoryFood = newValue!;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'รายละเอียดสินค้า'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณาใส่รายละเอียดสินค้า';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _productDetail = newValue!;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _date,
                  decoration: InputDecoration(
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
                    _deliveryDate = newValue!;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'เวลาที่จัดส่ง',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณาใส่เวลาที่จัดส่ง';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _deliveryTime = newValue!;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'เพิ่มรูปภาพ',
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.add_a_photo),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'กรุณาใส่ประเภทสินค้า';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _catagoryFood = newValue!;
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

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Processing Save : $_productName'),
                            ),
                          );
                        }
                      },
                      child: Text('สร้างรายการสินค้า'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          _formkey.currentState!.save();

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Processing Save : $_productName'),
                            ),
                          );
                        }
                      },
                      child: Text('ล้างข้อมูล'),
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
