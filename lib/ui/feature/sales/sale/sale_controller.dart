import 'package:basic_app/data/repositories/product_repository.dart';
import 'package:basic_app/data/repositories/seller_repository.dart';
import 'package:basic_app/domain/models/product.dart';
import 'package:basic_app/domain/models/sale_item.dart';
import 'package:basic_app/domain/models/seller.dart';
import 'package:flutter/material.dart';

class SaleController extends ChangeNotifier {
  final ProductRepository _productRepository = ProductRepository();
  final SellerRepository _sellerRepository = SellerRepository();
  List<Product> get products => _products;
  List<Product> _products = [];

  List<SaleItem> selectedProducts = [];

  List<Seller> get sellers => _sellers;
  List<Seller> _sellers = [];

  int? _selectedSellerId;

  Future<void> fetchProducts([String searchText = '']) async {
    var res = await _productRepository.getProducts(searchText);
    _products = res.getOrDefault([]);

    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    SaleItem? item = selectedProducts
        .where((e) => e.produtoCodigo == product.codigo)
        .firstOrNull;

    if (item == null) {
      selectedProducts.add(SaleItem(
          quantidade: 1,
          valor: product.valor,
          produtoCodigo: product.codigo,
          descricao: product.descricao));
      notifyListeners();
      return;
    }
    item.quantidade++;
    notifyListeners();
  }

  double get totalValue => selectedProducts.fold(
      0, (sum, item) => sum + (item.valor * item.quantidade));

  Future<void> fetchSellers() async {
    var res = await _sellerRepository.getSeller();
    _sellers = res.getOrDefault([]);

    notifyListeners();
  }

  void selectSeller(int sellerId) {
    if (_selectedSellerId == sellerId) {
      _selectedSellerId = null;
    } else {
      _selectedSellerId = sellerId;
    }
    notifyListeners();
  }

  bool isSelected(int sellerId) => _selectedSellerId == sellerId;
}
