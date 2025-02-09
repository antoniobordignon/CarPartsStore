import 'dart:convert';

import 'package:basic_app/data/services/api_service.dart';
import 'package:basic_app/domain/models/sale.dart';
import 'package:basic_app/domain/models/sale_item.dart';
import 'package:basic_app/main.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

class SaleRepository {
  final _api = IApiService(currentLoggedUser);
  Future<Result> createSale(List<SaleItem> items, int sellerId) async {
    double valorTotal = 0;
    for (var item in items) {
      valorTotal += item.valor * item.quantidade;
    }

    var sale = Sale(
      horario: DateTime.now(),
      valorTotal: valorTotal,
      funcionarioCodigo: sellerId,
      itens: items,
    );

    var res = await _api.post('v1/order/create-order', body: sale.toJson());

    if (res.error == null) {
      return successOf(res);
    }

    return failureOf(Exception(res.error));
  }

  Future<Result<List<Sale>>> getSales() async {
    List<Sale> sales = [];

    var res = await _api.get('/v1/product/products');

    if (!res.hasSucess) {
      return failureOf(Exception(res.error ?? res.body ?? 'Não foi possível buscar as vendas. Motivo desconhecido.'));
    }
    if (!res.canBeParsed) {
      return failureOf(Exception('Não foi possível realizar o parse das vendas.'));
    }

    var jsonBody = jsonDecode(res.body!);

    for (var item in jsonBody) {
      sales.add(Sale.fromJson(item));
    }

    return successOf(sales);
  }
}
