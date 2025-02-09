class Seller {
  final int codigo;
  final String nome;

  Seller({
    required this.codigo,
    required this.nome,
  });

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
      codigo: json['codigo'],
      nome: json['nome'],
    );
  }
}