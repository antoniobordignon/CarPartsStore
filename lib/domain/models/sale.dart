import 'package:basic_app/domain/models/sale_item.dart';

class Sale {
  final DateTime horario;
  final double valorTotal;
  final int funcionarioCodigo;
  final List<SaleItem> itens;

  Sale({
    required this.horario,
    required this.valorTotal,
    required this.funcionarioCodigo,
    required this.itens,
  });

  Map<String, dynamic> toJson() {
    return {
      'horario': horario.toIso8601String(),
      'valorTotal': valorTotal,
      'funcionarioCodigo': funcionarioCodigo,
      'itens': itens.map((e) => e.toJson()).toList(),
    };
  }

  factory Sale.fromJson(Map<String, dynamic> json) {
    return Sale(
      horario: DateTime.parse(json['horario']),
      valorTotal: json['valorTotal'],
      funcionarioCodigo: json['funcionarioCodigo'],
      itens: [],
    );
  }
}
