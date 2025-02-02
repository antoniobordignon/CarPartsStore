class Product {
  final int codigo;
  final String descricao;
  final double valor;
  final double quantidade;
  final int fornecedorCodigo;

  Product({
    required this.codigo,
    required this.descricao,
    required this.valor,
    required this.quantidade,
    required this.fornecedorCodigo,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      codigo: json['codigo'],
      descricao: json['descricao'],
      valor: json['valor'],
      quantidade: (json['quantidade'] as num).toDouble(),
      fornecedorCodigo: json['fornecedorCodigo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codigo': codigo,
      'descricao': descricao,
      'valor': valor,
      'quantidade': quantidade,
      'fornecedorCodigo': fornecedorCodigo,
    };
  }
}
