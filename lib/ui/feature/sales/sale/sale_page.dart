import 'package:basic_app/domain/models/product.dart';
import 'package:basic_app/ui/feature/sales/sale/components/product_button_widget.dart';
import 'package:basic_app/ui/feature/sales/sale/sale_controller.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SalePage extends StatefulWidget {
  const SalePage({super.key});

  @override
  State<SalePage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<SalePage> {
  late SaleController _controller;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _controller.fetchProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SaleController(),
      builder: (context, child) {
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;
        _controller = context.watch<SaleController>();
        return LayoutBuilder(
          builder: (context, constraints) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor:
                    Theme.of(context).colorScheme.secondaryContainer,
                title: Center(
                  child: Text(
                    'Realize a venda',
                    style: TextStyle(
                      fontSize: screenWidth * .02,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio:
                              (screenWidth / 3) / (screenHeight * 0.1),
                        ),
                        itemCount: _controller.products.length,
                        itemBuilder: (context, index) {
                          var model = _controller.products[index];
                          return ProductButtonWidget(
                            description: model.descricao,
                            value: model.valor,
                            onSelect: () => _controller.addProduct(model),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Carrinho',
                              style: TextStyle(
                                fontSize: screenWidth * .015,
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: _controller.selected.length,
                                itemBuilder: (context, index) {
                                  var product = _controller.selected[index];
                                  return ListTile(
                                    title: Text(product.descricao),
                                    subtitle: Text('Valor: ${product.valor} \nQuantidade: ${product.quantidade}'),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
