import 'package:basic_app/ui/feature/sales/sale/sale_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaleListPage extends StatefulWidget {
  const SaleListPage({super.key});

  @override
  State<SaleListPage> createState() => _SaleListPageState();
}

class _SaleListPageState extends State<SaleListPage> {
  late SaleController _controller;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((t) async {
      _controller.getSales();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    _controller = context.watch<SaleController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de vendas'),
      ),
      body: ListView.builder(
        itemCount: _controller.sales.length,
        itemBuilder: (context, index) {
          var model = _controller.sales[index];
          return Card.filled(
            child: ListTile(
              title: Text('Funcionário: ' + model.funcionarioCodigo.toString()),
              subtitle: Text('Horário:' + model.horario.toIso8601String()),
              trailing: Text('Valor total: ' + model.valorTotal.toString()),
            ),
          );
        },
      ),
    );
  }
}
