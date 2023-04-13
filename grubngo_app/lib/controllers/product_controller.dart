import 'dart:async';

import '../models/products_model.dart';
import '../services/product_services.dart';

class ProductController {
  final ProductServices services;
  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  List<Product> products = List.empty();
  ProductController(this.services);

  Future<List<Product>> get() async {
    // controller status => Start
    onSyncController.add(true);
    products = await services.get();
    // controller status => End
    onSyncController.add(false);

    return products;
  }

  update(Product item) {
    services.update(item);
  }

  insert(Product item) {
    services.insert(item);
  }
}
