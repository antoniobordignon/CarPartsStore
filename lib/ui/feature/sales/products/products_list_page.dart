import 'package:basic_app/ui/feature/sales/products/components/product_component_widget.dart';
import 'package:basic_app/ui/feature/sales/products/products_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late ProductsListController _controller;

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
      create: (context) => ProductsListController(),
      builder: (context, child) {
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;
        _controller = context.watch<ProductsListController>();
        return LayoutBuilder(
          builder: (context, constraints) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor:
                    Theme.of(context).colorScheme.secondaryContainer,
                title: Center(
                  child: Text(
                    'Lista de produtos',
                    style: TextStyle(
                      fontSize: screenWidth * .02,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
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
                    return ProductComponentWidget(
                        description: model.descricao,
                        value: model.valor,
                        stock: model.quantidade);
                  },
                ),
              ),
            );
          },
        );

        // return Scaffold(
        //   appBar: AppBar(
        //     title: Text('Produtos'),
        //     actions: [
        //       IconButton(
        //         icon: Icon(Icons.refresh),
        //         onPressed: () async {
        //           await _controller.fetchProducts();
        //         },
        //       ),
        //     ],
        //   ),
        //   body: ListView.builder(
        //     itemCount: _controller.products.length,
        //     itemBuilder: (context, index) {
        //       var product = _controller.products[index];
        //       return ProductComponentWidget(
        //         description: product.descricao,
        //         value: product.valor,
        //         stock: product.quantidade,
        //       );
        //     },
        //   ),
        // );
      },
    );
  }
}



// class ShowCard extends StatefulWidget {
//   final double screenHeight;
//   final double screenWidth;

//   const ShowCard({
//     super.key,
//     required this.screenHeight,
//     required this.screenWidth,
//   });

//   @override
//   State<ShowCard> createState() => _ShowCardState();
// }

// class _ShowCardState extends State<ShowCard> {
//   int count = 0;

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }
