import 'dart:convert';
import 'dart:developer';

import 'package:basic_app/data/services/api_service.dart';
import 'package:basic_app/domain/models/seller.dart';
import 'package:basic_app/main.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

class SellerRepository {
  SellerRepository();

  final IApiService _apiService = IApiService(currentLoggedUser);
  Future<Result<List<Seller>>> getSeller() async {
    List<Seller> seller = [];

    var res = await _apiService.get('/v1/employee/employees');
    
    log('$seller');
    
    log('$_apiService');
    if (!res.hasSucess) {
      return failureOf(Exception(res.error ?? res.body ?? 'Não foi possível buscar os produtos. Motivo desconhecido.'));
    }
    if (!res.canBeParsed) {
      return failureOf(Exception('Não foi possível realizar o parse dos produtos.'));
    }

    var jsonBody = jsonDecode(res.body!);

    for (var item in jsonBody) {
      seller.add(Seller.fromJson(item));
    }

    return successOf(seller);
  }
}