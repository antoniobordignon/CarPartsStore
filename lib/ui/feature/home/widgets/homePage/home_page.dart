import 'package:basic_app/ui/feature/sales/products/products_list_page.dart';
import 'package:basic_app/util/navigation/util_navigation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Basic Lojas',
            style: TextStyle(
              fontSize: screenWidth * .02,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.onError,
        child: ListView(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.05,
                  horizontal: screenWidth * 0.02,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, UtilNavigation.nextPageFromBottom(page: ProductListPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.02,
                      horizontal: screenWidth * 0.04,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Iniciar venda',
                    style: TextStyle(
                      fontSize: screenWidth * 0.02,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
