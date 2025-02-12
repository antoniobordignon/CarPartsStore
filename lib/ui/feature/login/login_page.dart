import 'dart:developer';

import 'package:basic_app/data/services/api_service.dart';
import 'package:basic_app/domain/models/user.dart';
import 'package:basic_app/ui/core/components/text_field_with_label_widget.dart';
import 'package:basic_app/ui/feature/home/widgets/homePage/home_page.dart';
import 'package:basic_app/ui/feature/login/login_controller.dart';
import 'package:basic_app/util/navigation/util_navigation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:result_dart/result_dart.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginController _controller;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginController(),
      builder: (context, child) {
        _controller = Provider.of<LoginController>(context);
        return Scaffold(
            body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Chicão auto peças'.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 620,
                width: 700,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(80),
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(70),
                    bottomLeft: Radius.circular(20),
                  ),
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(80),
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(70),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(80),
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(70),
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(80),
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(70),
                                bottomLeft: Radius.circular(20),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(80),
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(70),
                                bottomLeft: Radius.circular(20),
                              ),
                              child: Image.asset(
                                width: 400,
                                height: 400,
                                fit: BoxFit.fill,
                                "assets/logo.png",
                              ),
                            ),
                          ),
                        ),
                        TextFieldWithLabelWidget(
                          labelText: 'Usuário',
                          onChanged: _controller.onChangedLogin,
                        ),
                        TextFieldWithLabelWidget(
                          labelText: 'Senha',
                          passwordField: true,
                          onChanged: _controller.onChangedPassword,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 400,
                    height: 50,
                    child: FilledButton(
                        onPressed: () async {
                          var result = await _controller.onLogin();
                          if (result.isError()) {
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).removeCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                result.exceptionOrNull().toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ));
                          }
                          if (result.isSuccess()) {
                            if (!context.mounted) return;
                            Navigator.push(context, UtilNavigation.nextPageFromRight(page: const HomePage()));
                          }
                        },
                        child: Text(
                          'Acessar',
                          style: TextStyle(
                            fontSize: 24,
                            //color: Theme.of(context).colorScheme.onSurface,
                          ),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ));
      },
    );
  }
}
