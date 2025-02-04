import 'package:flutter/material.dart';

class ProductButtonWidget extends StatelessWidget {
  final String description;
  final double value;
  final VoidCallback onSelect;

  const ProductButtonWidget({
    super.key,
    required this.description,
    required this.value,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
      ),
      onPressed: onSelect,
      child: ListTile(
        title: Text(description),
        subtitle: Column(
          children: [
            Row(
              children: [Text(value.toString())],
            ),
          ],
        ),
      ),
    );
  }
}
