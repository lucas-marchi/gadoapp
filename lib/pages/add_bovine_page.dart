import 'package:flutter/material.dart';

class AddBovinePage extends StatefulWidget {
  static const String routeName = 'addbovine';
  const AddBovinePage({super.key});

  @override
  State<AddBovinePage> createState() => _AddBovinePageState();
}

class _AddBovinePageState extends State<AddBovinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar bovino'),
      ),
      body: Center(
        child: Text('Add bovine'),
      ),
    );
  }
}