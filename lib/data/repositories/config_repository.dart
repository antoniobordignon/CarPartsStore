import 'package:basic_app/data/services/api_service.dart';
import 'package:basic_app/main.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

class ConfigRepository {
  Future<Result<bool>> createBackup() async {
    var user = currentLoggedUser;
    final apiService = IApiService(user);
    var res = await apiService.post('/v1/configuration/database/create-backup');

    if (!res.hasSucess) {
      return failureOf(Exception(res.error ?? res.body ?? 'Não foi possível realizar o backup. Motivo desconhecido.'));
    }

    return successOf(true);
  }

  Future<Result<bool>> restoreBackup() async {
    var user = currentLoggedUser;
    final apiService = IApiService(user);
    var res = await apiService.post('/v1/configuration/database/restore-last-backup');

    if (!res.hasSucess) {
      return failureOf(Exception(res.error ?? res.body ?? 'Não foi possível realizar o backup. Motivo desconhecido.'));
    }

    return successOf(true);
  }
}
