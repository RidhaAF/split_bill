import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:split_bill/utils/constants/constants.dart';
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
    return Scaffold(
      appBar: DefaultAppBar(
        title: 'Split Bill',
        style: TextStyle(
          fontSize: title2FS,
        ),
      ),
      body: const GradientBackground(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/bill/form'),
        tooltip: 'Add bill',
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
