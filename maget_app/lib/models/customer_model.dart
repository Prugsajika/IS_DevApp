import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  late String customerId;
  late String id;
  late String name;
  late String lastName;
  late String Gender;
  late String profilePicture;
  late String password;
  late String idCard;
  late String telNo;
  late String email;
  late bool status;

  Customer(this.customerId, this.id, this.name, this.lastName, this.Gender,
      this.password, this.idCard, this.telNo, this.email, this.status);

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      json['customerId'] as String,
      json['id'] as String,
      json['name'] as String,
      json['lastName'] as String,
      json['Gender'] as String,
      json['password'] as String,
      json['idCard'] as String,
      json['telNo'] as String,
      json['email'] as String,
      json['status'] as bool,
    );
  }
}

class AllCustomers {
  final List<Customer> customers;

  AllCustomers(this.customers);

  factory AllCustomers.fromJson(List<dynamic> json) {
    List<Customer> customers;

    customers = json.map((index) => Customer.fromJson(index)).toList();

    return AllCustomers(customers);
  }

  factory AllCustomers.fromSnapshot(QuerySnapshot s) {
    List<Customer> customers = s.docs.map((DocumentSnapshot ds) {
      Customer customer = Customer.fromJson(ds.data() as Map<String, dynamic>);
      customer.id = ds
          .id; //after mapping from firevase can insert or replace value before return list
      return customer;
    }).toList();
    return AllCustomers(customers);
  }
}
