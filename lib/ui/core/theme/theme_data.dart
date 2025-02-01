import 'package:flutter/material.dart';

ThemeData get themeData => ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue[900]!,
        dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
        brightness: Brightness.dark,
      ),
      dividerColor: Colors.transparent,
    );
