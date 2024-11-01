import 'package:flutter/material.dart';

class RacePage extends StatelessWidget {
  static const String routeName = 'race';
  const RacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todas as raças'),
      ),
      body: Center(),
    );
  }
}