import 'package:flutter/material.dart';
import 'package:split_bill/widgets/default_app_bar.dart';
import 'package:split_bill/widgets/gradient_background.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: DefaultAppBar(
        title: 'Split Bill',
      ),
      body: GradientBackground(),
    );
  }
}
