import 'package:flutter/material.dart';
import 'package:gadoapp/models/bovine.dart';
import 'package:gadoapp/providers/bovine_provider.dart';
import 'package:provider/provider.dart';

class BovineDetailsPage extends StatefulWidget {
  static const String routeName = 'bovinedetails';
  final String id;
  const BovineDetailsPage({super.key, required this.id});

  @override
  State<BovineDetailsPage> createState() => _BovineDetailsPageState();
}

class _BovineDetailsPageState extends State<BovineDetailsPage> {
  late Bovine bovine;
  late BovineProvider provider;

  @override
  void didChangeDependencies() {
    provider = Provider.of<BovineProvider>(
      context,
    );
    bovine = provider.findBovineById(widget.id);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bovine.name!, style: const TextStyle(overflow: TextOverflow.ellipsis),),
      ),
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () {

            }, 
            child: Text(bovine.description == null
              ? 'Adicionar Descrição'
              : 'Mostrar Descrição'),
          ),
          ListTile(
            title: Text(bovine.name!),
            subtitle: Text(bovine.breed!),
          ),
          
        ],
      ),
    );
  }
}