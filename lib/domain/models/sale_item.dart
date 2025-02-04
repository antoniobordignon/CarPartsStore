class SaleItem {
  double quantidade;
  final double valor;
  final int produtoCodigo;
  final String descricao;

  SaleItem ({
    required this.quantidade,
    required this.valor,
    required this.produtoCodigo,
    required this.descricao,
  });

  Map<String, dynamic> toJson() {
    return {
      'quantidade': quantidade,
      'valor': valor,
      'produtoCodigo': produtoCodigo,
    };
  }
}