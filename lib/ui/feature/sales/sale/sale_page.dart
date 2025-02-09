import 'package:basic_app/ui/feature/sales/sale/components/product_button_widget.dart';
import 'package:basic_app/ui/feature/sales/sale/components/select_seller_button.dart';
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
      await _controller.fetchSellers();
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
                      child: Scaffold(
                        body: Container(
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
                                  itemCount:
                                      _controller.selectedProducts.length,
                                  itemBuilder: (context, index) {
                                    var product =
                                        _controller.selectedProducts[index];
                                    return Padding(
                                      padding: EdgeInsets.all(2),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onInverseSurface),
                                        child: ListTile(
                                          title: Text(product.descricao),
                                          subtitle: Text(
                                              'Valor: ${product.valor} \nQuantidade: ${product.quantidade}'),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        bottomNavigationBar: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Selecione o vendedor"),
                                      content: SizedBox(
                                        height: screenHeight * 0.5,
                                        width: screenHeight * 0.3,
                                        child: ListView.builder(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemCount: _controller.sellers.length,
                                          itemBuilder: (context, index) {
                                            var model =
                                                _controller.sellers[index];
                                            return SellerButtonWidget(
                                              name: model.nome,
                                              code: model.codigo,
                                              onSelect: (bool? newValue) {
                                                if (newValue != null &&
                                                    newValue) {
                                                  _controller.selectSeller(
                                                      model.codigo);
                                                }
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text("Finalizar"),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text("Voltar"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                padding: EdgeInsets.symmetric(
                                  vertical: screenHeight * 0.01,
                                  horizontal: screenHeight * 0.01,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Finalizar venda',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.01,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text('Total da compra: ${_controller.totalValue}'),
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
