import 'dart:convert';

import 'package:basic_app/data/services/api_service.dart';
import 'package:basic_app/domain/models/product.dart';
import 'package:basic_app/main.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

class ProductRepository {
  ProductRepository();
  final IApiService _apiService = IApiService(currentLoggedUser);
  Future<Result<List<Product>>> getProducts(String description) async {
    List<Product> products = [];

    var res = await _apiService.get('/v1/product/products', queryParams: {'description': description});

    if (!res.hasSucess) {
      return failureOf(Exception(res.error ?? res.body ?? 'Não foi possível buscar os produtos. Motivo desconhecido.'));
    }
    if (!res.canBeParsed) {
      return failureOf(Exception('Não foi possível realizar o parse dos produtos.'));
    }

    var jsonBody = jsonDecode(res.body!);

    for (var item in jsonBody) {
      products.add(Product.fromJson(item));
    }

    return successOf(products);
  }
}
