import 'package:flutter/material.dart';
import 'package:gadoapp/customwidgets/radio_group.dart';
import 'package:gadoapp/models/herds.dart';
import 'package:gadoapp/providers/bovine_provider.dart';
import 'package:gadoapp/utils/constants.dart';
import 'package:provider/provider.dart';

class AddBovinePage extends StatefulWidget {
  static const String routeName = 'addbovine';
  const AddBovinePage({super.key});

  @override
  State<AddBovinePage> createState() => _AddBovinePageState();
}

class _AddBovinePageState extends State<AddBovinePage> {
  Herd? herd;
  final _formKey = GlobalKey<FormState>();
  String bovineStatus = BovineUtils.statusList.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar bovino'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Consumer<BovineProvider>(
                      builder: (context, provider, child) =>
                          DropdownButtonFormField<Herd>(
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                              hint: const Text('Adicionar á um rebanho'),
                              isExpanded: true,
                              value: herd,
                              items: provider.herdList
                                  .map((item) => DropdownMenuItem<Herd>(
                                      value: item, child: Text(item.name)))
                                  .toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'Selecione para qual rebanho será adicionado';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                herd = value;
                              }),
                    ))),
            RadioGroup(
              label: 'Status', 
              groupValue: bovineStatus, 
              items: BovineUtils.statusList, 
              onItemSelected: (value) {
                bovineStatus = value;
              })
          ],
        ),
      ),
    );
  }
}
