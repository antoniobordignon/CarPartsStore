import 'package:basic_app/ui/feature/sales/sale/sale_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaleListPage extends StatefulWidget {
  const SaleListPage({super.key});

  @override
  State<SaleListPage> createState() => _SaleListPageState();
}

class _SaleListPageState extends State<SaleListPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final _controller = context.watch<SaleController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de vendas'),
      ),
      body: ListView.builder(
        itemCount: _controller.sales.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_controller.sales[index].funcionarioCodigo.toString()),
            subtitle: Text(_controller.sales[index].horario.toIso8601String()),
            trailing: Text(_controller.sales[index].valorTotal.toString()),
          );
        },
      ),
    );
  }
}
