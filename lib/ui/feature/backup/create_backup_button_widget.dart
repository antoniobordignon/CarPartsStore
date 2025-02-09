import 'package:basic_app/ui/feature/backup/backup_controller.dart';
import 'package:basic_app/ui/feature/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateBackupButtonWidget extends StatelessWidget {
  const CreateBackupButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var viewModel = context.watch<BackupController>();
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(
          top: screenHeight * 0.05,
          left: screenWidth * 0.02,
        ),
        child: SizedBox(
          width: screenWidth * 0.3,
          child: ElevatedButton(
              onPressed: () {
                viewModel.onBackup();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.02,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: switch (viewModel.state) {
                BackupState.backuping => CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                BackupState.initial => Text(
                    'Fazer backup',
                    style: TextStyle(
                      fontSize: screenWidth * 0.02,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                BackupState.restoring => Text(
                    'Fazer backup',
                    style: TextStyle(
                      fontSize: screenWidth * 0.02,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                BackupState.error => Icon(
                    Icons.error,
                    color: Theme.of(context).colorScheme.error,
                  ),
              }),
        ),
      ),
    );
  }
}
