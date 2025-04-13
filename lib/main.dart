 import 'package:flutter/material.dart';
import 'package:todo_app/routes/routes.dart';
import 'package:todo_app/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Todo Application',
      theme: AppTheme.darkThemeMode,
      routerConfig: router,
    );
  }
}

