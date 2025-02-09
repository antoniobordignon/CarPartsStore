import 'package:basic_app/data/repositories/config_repository.dart';
import 'package:flutter/material.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

enum BackupState { initial, backuping, restoring, error }

class BackupController extends ChangeNotifier {
  final _repository = ConfigRepository();

  var state = BackupState.initial;
  Future<Result> onBackup() async {
    state = BackupState.backuping;
    notifyListeners();
    await _repository.createBackup();
    state = BackupState.initial;
    notifyListeners();
    return successOf(true);
  }

  Future onRestore() async {
    state = BackupState.restoring;
    notifyListeners();
    await _repository.restoreBackup();
    state = BackupState.initial;
    notifyListeners();
  }
}
