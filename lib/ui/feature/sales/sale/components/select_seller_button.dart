import 'dart:developer';

import 'package:basic_app/ui/feature/login/login_page.dart';
import 'package:basic_app/ui/feature/sales/sale/sale_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SellerButtonWidget extends StatefulWidget {
  final String name;
  final int code;

  const SellerButtonWidget({
    super.key,
    required this.name,
    required this.code,
  });

  @override
  State<SellerButtonWidget> createState() => _SellerButtonWidgetState();
}

class _SellerButtonWidgetState extends State<SellerButtonWidget> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SaleController>();
    return CheckboxListTile(
      value: viewModel.selectedSeller == widget.code,
      onChanged: (_) {
        viewModel.selectSeller(widget.code);
      },
      title: Text('${widget.code} - ${widget.name}'),
    );
  }
}
