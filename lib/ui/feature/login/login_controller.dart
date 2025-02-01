import 'package:basic_app/data/repositories/login_repository.dart';
import 'package:flutter/material.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

class LoginController extends ChangeNotifier {
  final LoginRepository _repository = LoginRepository();

  String? login;
  String? password;

  void onChangedLogin(String aValue) {
    login = aValue;
    notifyListeners();
  }

  void onChangedPassword(String aValue) {
    password = aValue;
    notifyListeners();
  }

  Future<Result<bool>> onLogin() async {
    if (login == null || password == null) {
      return failureOf(Exception('Login ou senha inválidos'));
    }

    return await _repository.login(login!, password!);
  }
}
