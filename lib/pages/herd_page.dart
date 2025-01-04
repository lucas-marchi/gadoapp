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
                  return InkWell(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Card(
                        color: const Color.fromRGBO(222, 227, 227, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        elevation: 0,
                        child: Row(
                          children: [
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    herd.name,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      // final filteredBovines = provider.bovineList
                      //     .where((bovine) => bovine.herd!.id == herd.id)
                      //     .toList();
                      // Navigator.of(context).pushNamed(
                      //   ViewBovinePage.routeName,
                      //   arguments: filteredBovines,
                      // );
                    },
                  );
                },
              ),
      ),
    );
  }
}
