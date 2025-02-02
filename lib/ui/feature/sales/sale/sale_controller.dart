import 'package:basic_app/domain/models/product.dart';
import 'package:flutter/material.dart';

class SaleController extends ChangeNotifier {
  List<Product> products = [];

  Future<void> addProduct(Product product) async {
    products.add(product);
    notifyListeners();
  }
}
