import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gadoapp/providers/bovine_provider.dart';
import 'package:gadoapp/utils/widget_functions.dart';
import 'package:provider/provider.dart';

class HerdPage extends StatelessWidget {
  static const String routeName = 'herd';

  const HerdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos os rebanhos'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSingleTextInputDialog(
            context: context,
            title: 'Adicionar Rebanho',
            onSubmit: (value) {
              EasyLoading.show(status: 'Aguarde...');
              Provider.of<BovineProvider>(context, listen: false)
                  .addHerd(value)
                  .then((value) {
                EasyLoading.dismiss();
                showMsg(context, 'Novo rebanho adicionado');
              });
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<BovineProvider>(
        builder: (context, provider, child) => provider.herdList.isEmpty
            ? const Center(
                child: Text('Nenhum rebanho encontrado'),
              )
            : ListView.builder(
                itemCount: provider.herdList.length,
                itemBuilder: (context, index) {
                  final herd = provider.herdList[index];
                  return ListTile(
                    title: Text(herd.name),
                  );
                },
              ),
      ),
    );
  }
}
