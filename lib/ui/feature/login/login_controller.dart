import 'package:basic_app/data/repositories/login_repository.dart';
import 'package:basic_app/domain/models/user.dart';
import 'package:basic_app/main.dart';
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

    var res = await _repository.login(login!, password!);
    if (res.isSuccess()) {
      currentLoggedUser = User(login: login!, password: password!);
    }

    return res;
  }
}
