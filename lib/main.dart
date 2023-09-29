import 'package:flutter/material.dart';
import 'package:split_bill/utils/routes/routes.dart';
import 'package:split_bill/utils/themes/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Split Bill',
      debugShowCheckedModeBanner: false,
      theme: AppTheme().appTheme,
      routerConfig: appRouter,
    );
  }
}
