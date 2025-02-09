import 'package:basic_app/ui/feature/backup/create_backup_button_widget.dart';
import 'package:basic_app/ui/feature/backup/backup_controller.dart';
import 'package:basic_app/ui/feature/backup/restore_backup_button_widget.dart';
import 'package:basic_app/ui/feature/home/widgets/homePage/functionally_button_widget.dart';
import 'package:basic_app/ui/feature/sales/products/products_list_page.dart';
import 'package:basic_app/ui/feature/sales/sale/sale_controller.dart';
import 'package:basic_app/ui/feature/sales/sale/sale_list_page.dart';
import 'package:basic_app/ui/feature/sales/sale/sale_page.dart';
import 'package:basic_app/util/navigation/util_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SaleController(),
        ),
        ChangeNotifierProvider(
          create: (context) => BackupController(),
        ),
      ],
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            title: Center(
              child: Text(
                'Basic Lojas',
                style: TextStyle(
                  fontSize: screenWidth * .02,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          body: ListView(
            children: [
              FunctionallyButtonWidget(
                  onTap: () {
                    Navigator.push(
                      context,
                      UtilNavigation.nextPageFromBottom(
                          page: ChangeNotifierProvider.value(
                        value: context.read<SaleController>(),
                        builder: (context, child) {
                          return SalePage();
                        },
                      )),
                    );
                  },
                  text: 'Realizar venda'),
              FunctionallyButtonWidget(
                  onTap: () {
                    Navigator.push(
                      context,
                      UtilNavigation.nextPageFromBottom(
                          page: ChangeNotifierProvider.value(
                        value: context.read<SaleController>(),
                        builder: (context, child) {
                          return SaleListPage();
                        },
                      )),
                    );
                  },
                  text: 'Historico de Vendas'),
              CreateBackupButtonWidget(),
              RestoreBackupButtonWidget(),
            ],
          ),
        );
      },
    );
  }
}
