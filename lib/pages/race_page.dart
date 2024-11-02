import 'package:flutter/material.dart';
import 'package:gadoapp/providers/bovine_provider.dart';
import 'package:provider/provider.dart';

class RacePage extends StatelessWidget {
  static const String routeName = 'race';
  
  const RacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todas as raças'),
      ),
      body: Consumer<BovineProvider>(
        builder: (context, provider, child) => provider.raceList.isEmpty
            ? const Center(child: Text('Nenhuma raça encontrada'),)
            : ListView.builder(
                itemCount: provider.raceList.length,
                itemBuilder: (context, index) {
                  final race = provider.raceList[index];
                  return ListTile(
                    title: Text(race.name),
                  );
                },
              ),
      ),
    );
  }
}
