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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    _controller = context.watch<SaleController>();
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
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
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 21, top: 15),
                        child: SearchBar(
                          leading: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.search,
                              size: 32,
                            ),
                          ),
                          controller: _controller.searchController,
                        ),
                      ),
                      Expanded(
                        child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: (screenWidth / 3) / (screenHeight * 0.1),
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
                    ],
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
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondaryContainer,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Carrinho',
                                  style: TextStyle(
                                    fontSize: screenWidth * .015,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  Icons.shopping_cart,
                                  size: screenWidth * .055,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: _controller.selectedProducts.length,
                              itemBuilder: (context, index) {
                                var product = _controller.selectedProducts[index];
                                return Padding(
                                  padding: EdgeInsets.all(2),
                                  child: Container(
                                    decoration: BoxDecoration(color: Theme.of(context).colorScheme.onInverseSurface),
                                    child: ListTile(
                                      title: Text(product.descricao),
                                      subtitle: Text('Valor: ${product.valor} \nQuantidade: ${product.quantidade}'),
                                      trailing: IconButton(
                                          onPressed: () async {
                                            await showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text('Remover o produto ${product.descricao} ?'),
                                                  content: ElevatedButton(
                                                    onPressed: () {
                                                      _controller.removeProduct(product);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Remover'),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Theme.of(context).colorScheme.error,
                                          )),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    bottomNavigationBar: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('R\$${_controller.totalValue.toStringAsFixed(2).replaceAll('.', ',')}', style: TextStyle(fontSize: screenWidth * 0.015)),
                        SizedBox(
                          width: screenWidth * 0.25,
                          height: screenHeight * 0.1,
                          child: ElevatedButton(
                            onPressed: () {
                              _controller.totalValue <= 0
                                  ? showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            'Adicione produtos para concluir a venda!',
                                            style: TextStyle(
                                              fontSize: screenWidth * 0.01,
                                            ),
                                          ),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () => Navigator.pop(context),
                                              child: const Text("Voltar"),
                                            ),
                                          ],
                                        );
                                      })
                                  : showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ChangeNotifierProvider.value(
                                          value: _controller,
                                          builder: (context, child) {
                                            return AlertDialog(
                                              title: const Text("Selecione o vendedor"),
                                              content: SizedBox(
                                                height: screenHeight * 0.5,
                                                width: screenHeight * 0.3,
                                                child: ListView.builder(
                                                  physics: const BouncingScrollPhysics(),
                                                  itemCount: _controller.sellers.length,
                                                  itemBuilder: (context, index) {
                                                    var model = _controller.sellers[index];
                                                    return SellerButtonWidget(
                                                      name: model.nome,
                                                      code: model.codigo,
                                                    );
                                                  },
                                                ),
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () => Navigator.pop(context),
                                                  child: const Text("Voltar"),
                                                ),
                                                FilledButton(
                                                  onPressed: () async {
                                                    var res = await _controller.sendSale();
                                                    if (!context.mounted) return;
                                                    if (res.isError()) {
                                                      await showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title: const Text("Erro ao enviar a venda"),
                                                            content: Text(res.exceptionOrNull().toString()),
                                                            actions: [
                                                              ElevatedButton(
                                                                onPressed: () => Navigator.pop(context),
                                                                child: const Text("Voltar"),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                      return;
                                                    }
                                                    if (res.isSuccess()) {
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                  child: const Text("Finalizar"),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
  }
}
