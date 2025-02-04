import 'package:basic_app/data/repositories/product_repository.dart';
import 'package:basic_app/domain/models/product.dart';
import 'package:basic_app/domain/models/sale_item.dart';
import 'package:flutter/material.dart';

class SaleController extends ChangeNotifier {
  final ProductRepository _productRepository = ProductRepository();
  List<Product> get products => _products;
  List<Product> _products = [];

  List<SaleItem> selected = [];

  Future<void> fetchProducts([String searchText = '']) async {
    var res = await _productRepository.getProducts(searchText);
    _products = res.getOrDefault([]);

    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    SaleItem? item = selected.where((e) => e.produtoCodigo == product.codigo).firstOrNull;

    if(item == null) {
      selected.add(SaleItem(quantidade: 1, valor: product.valor, produtoCodigo: product.codigo, descricao: product.descricao));
      notifyListeners(); 
      return;
    }
    item.quantidade ++;
    notifyListeners();
  }
}
