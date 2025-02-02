import 'package:basic_app/data/repositories/product_repository.dart';
import 'package:basic_app/domain/models/product.dart';
import 'package:flutter/material.dart';

class ProductsListController extends ChangeNotifier {
  final ProductRepository _productRepository = ProductRepository();
  List<Product> get products => _products;

  List<Product> _products = [];

  Future<void> fetchProducts([String searchText = '']) async {
    var res = await _productRepository.getProducts(searchText);
    _products = res.getOrDefault([]);

    notifyListeners();
  }
}
