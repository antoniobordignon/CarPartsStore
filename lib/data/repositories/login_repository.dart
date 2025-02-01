import 'package:basic_app/data/services/api_service.dart';
import 'package:basic_app/domain/models/user.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

class LoginRepository {
  Future<Result<bool>> login(String login, String password) async {
    var user = User(login: login, password: password);
    final apiService = IApiService(user);
    var res = await apiService.post('/v1/user/login');

    if (!res.hasSucess) {
      return failureOf(Exception(res.error ?? res.body ?? 'Não foi possível realizar o login. Motivo desconhecido.'));
    }

    return successOf(true);

    // Simulate a successful login
  }
}
