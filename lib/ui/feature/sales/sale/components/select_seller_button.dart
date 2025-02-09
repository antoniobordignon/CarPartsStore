import 'package:flutter/material.dart';

class SellerButtonWidget extends StatelessWidget {
  final String name;
  final int code;
  final ValueChanged<bool?> onSelect;

  const SellerButtonWidget({
    super.key,
    required this.name,
    required this.code,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: false, 
      onChanged: onSelect,
      title: Text('$code - $name'),
    );
  }
}