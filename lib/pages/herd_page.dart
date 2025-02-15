import 'package:flutter/material.dart';
import 'package:gadoapp/models/herd.dart';
import 'package:gadoapp/pages/view_bovine_page.dart';
import 'package:gadoapp/services/database_service.dart';
import 'package:gadoapp/utils/widget_functions.dart';

class HerdPage extends StatefulWidget {
  static const String routeName = 'herd';
  final VoidCallback? onUpdate;

  const HerdPage({super.key, this.onUpdate});

  @override
  State<HerdPage> createState() => _HerdPageState();
}

class _HerdPageState extends State<HerdPage> {
  final DatabaseService _databaseService = DatabaseService.instance;

  String? _herd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSingleTextInputDialog(
            context: context,
            title: 'Adicionar Rebanho',
            onSubmit: (value) {
              _herd = value;
              if (_herd == null || _herd == "") return;
              _databaseService.addHerd(_herd!);
              setState(() {});
              DatabaseService.registerChange();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: _herdsList(),
    );
  }

  Widget _herdsList() {
    return FutureBuilder<List<Herd>>(
      future: _databaseService.getHerds(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.data!.isEmpty) {
          return const Center(child: Text('Nenhum rebanho encontrado'));
        }

        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final herd = snapshot.data![index];
            const bovineCount = 0;

            return InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  ViewBovinePage.routeName,
                  arguments: herd.id,
                );
              },
              onLongPress: () {
                _databaseService.deleteHerd(herd.id);
                setState(() {});
                DatabaseService.registerChange();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Card(
                  elevation: 4.0,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                herd.name,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              const Text(
                                '$bovineCount cabeças',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}