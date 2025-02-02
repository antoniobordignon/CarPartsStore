import 'package:flutter/material.dart';

class ProductComponentWidget extends StatelessWidget {
  final String description;
  final double value;
  final double stock;

  const ProductComponentWidget({super.key, required this.description, required this.value, required this.stock});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(description),
      subtitle: Column(
        children: [
          Row(
            children: [Text(value.toString())],
          ),
          Row(
            children: [Text(stock.toString())],
          ),
        ],
      ),
    );
  }
}
