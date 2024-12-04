import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gadoapp/models/bovine.dart';
import 'package:gadoapp/pages/herd_page.dart';
import 'package:gadoapp/pages/view_bovine_page.dart';
import 'package:gadoapp/providers/bovine_provider.dart';
import 'package:gadoapp/utils/widget_functions.dart';
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
        title: Text(
          bovine.name!,
          style: const TextStyle(overflow: TextOverflow.ellipsis),
        ),
        actions: [
          IconButton(onPressed: _deleteBovine, icon: const Icon(Icons.delete))
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Nome ou brinco:  ${bovine.name!}'),
            trailing: IconButton(
              onPressed: () {
                showSingleTextInputDialog(
                    context: context,
                    title: 'Editar nome ou brinco',
                    onSubmit: (value) {
                      EasyLoading.show(status: 'Aguarde...');
                      provider
                          .updateBovineFields(bovine.id!, 'name', value)
                          .then((value) {
                        EasyLoading.dismiss();
                        showMsg(context, 'Nome atualizado!');
                      });
                    });
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          ListTile(
            title: Text('Raça: ${bovine.breed!}'),
            trailing: IconButton(
              onPressed: () {
                showSingleTextInputDialog(
                    context: context,
                    title: 'Editar raça',
                    onSubmit: (value) {
                      EasyLoading.show(status: 'Aguarde...');
                      provider
                          .updateBovineFields(bovine.id!, 'breed', value)
                          .then((value) {
                        EasyLoading.dismiss();
                        showMsg(context, 'Raça atualizado!');
                      });
                    });
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          ListTile(
            title: Text('Status: ${bovine.status}'),
            trailing: IconButton(
              onPressed: () {
                showSingleTextInputDialog(
                    context: context,
                    title: 'Editar status',
                    onSubmit: (value) {
                      EasyLoading.show(status: 'Aguarde...');
                      provider
                          .updateBovineFields(bovine.id!, 'status', value)
                          .then((value) {
                        EasyLoading.dismiss();
                        showMsg(context, 'Status atualizado!');
                      });
                    });
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          ListTile(
            title: Text('Peso: ${bovine.weight.toString()}kg'),
            trailing: IconButton(
              onPressed: () {
                showSingleTextInputDialog(
                    context: context,
                    title: 'Editar peso',
                    onSubmit: (value) {
                      EasyLoading.show(status: 'Aguarde...');
                      provider
                          .updateBovineFields(
                              bovine.id!, 'weight', num.parse(value))
                          .then((value) {
                        EasyLoading.dismiss();
                        showMsg(context, 'Peso atualizado!');
                      });
                    });
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          ListTile(
            title: Text('Data de nascimento: ${bovine.birth.toString()}'),
            trailing: IconButton(
              onPressed: () {
                showSingleTextInputDialog(
                    context: context,
                    title: 'Editar data de nascimento',
                    onSubmit: (value) {
                      EasyLoading.show(status: 'Aguarde...');
                    });
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          ListTile(
            title: Text('Sexo: ${bovine.gender}'),
            trailing: IconButton(
              onPressed: () {
                showSingleTextInputDialog(
                    context: context,
                    title: 'Editar genero',
                    onSubmit: (value) {
                      EasyLoading.show(status: 'Aguarde...');
                    });
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          ListTile(
            title: Text('Descrição: ${bovine.description!}'),
            trailing: IconButton(
              onPressed: () {
                showSingleTextInputDialog(
                    context: context,
                    title: 'Editar descrição',
                    onSubmit: (value) {
                      EasyLoading.show(status: 'Aguarde...');
                      provider
                          .updateBovineFields(bovine.id!, 'description', value)
                          .then((value) {
                        EasyLoading.dismiss();
                        showMsg(context, 'Descrição atualizado!');
                      });
                    });
              },
              icon: const Icon(Icons.edit),
            ),
          ),
        ],
      ),
    );
  }

  void _deleteBovine() async {
    EasyLoading.show(status: 'Aguarde');
    try {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Confirmação'),
          content:
              const Text('Você tem certeza que deseja excluir este bovino?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                provider.deleteBovine(bovine.id!).then((value){
                  EasyLoading.dismiss();
                  showMsg(context, 'Excluído');
                });
                Navigator.popUntil(
                    context, ModalRoute.withName(ViewBovinePage.routeName));
              },
              child: const Text('Excluir', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      );
    } catch (error) {
      EasyLoading.dismiss();
      print(error.toString());
    }
  }

  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmação'),
        content: const Text('Você tem certeza que deseja excluir este bovino?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              provider.deleteBovine(bovine.id!);
              Navigator.popUntil(
                  context, ModalRoute.withName(HerdPage.routeName));
            },
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
