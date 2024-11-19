import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gadoapp/customwidgets/radio_group.dart';
import 'package:gadoapp/models/bovine.dart';
import 'package:gadoapp/models/herd.dart';
import 'package:gadoapp/providers/bovine_provider.dart';
import 'package:gadoapp/utils/constants.dart';
import 'package:gadoapp/utils/widget_functions.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddBovinePage extends StatefulWidget {
  static const String routeName = 'addbovine';
  const AddBovinePage({super.key});

  @override
  State<AddBovinePage> createState() => _AddBovinePageState();
}

class _AddBovinePageState extends State<AddBovinePage> {
  final _nameController = TextEditingController();
  final _breedController = TextEditingController();
  final _weightController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _birthController = TextEditingController();

  Bovine? mom;
  Bovine? dad;
  Herd? herd;
  final _formKey = GlobalKey<FormState>();
  String bovineStatus = BovineUtils.statusList.first;
  String bovineGender = BovineUtils.genderList.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar bovino'),
        actions: [
          IconButton(onPressed: _saveBovine, icon: const Icon(Icons.done))
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  labelText: 'Nome ou brinco:',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo não pode ser nulo';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextFormField(
                controller: _breedController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  labelText: 'Raça:',
                ),
              ),
            ),
            RadioGroup(
                label: 'Status:',
                groupValue: bovineStatus,
                items: BovineUtils.statusList,
                onItemSelected: (value) {
                  bovineStatus = value;
                }),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _weightController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  labelText: 'Peso:',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _birthController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  labelText: 'Data de nascimento:',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () {
                  _selectDate();
                },
              ),
            ),
            RadioGroup(
                label: 'Sexo:',
                groupValue: bovineGender,
                items: BovineUtils.genderList,
                onItemSelected: (value) {
                  bovineGender = value;
                }),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  labelText: 'Descrição:',
                ),
              ),
            ),
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
                    Card(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Consumer<BovineProvider>(
                      builder: (context, provider, child) =>
                          DropdownButtonFormField<Bovine>(
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                              hint: const Text('Selecionar pai'),
                              isExpanded: true,
                              value: dad,
                              items: provider.bovineList
                                  .map((item) => DropdownMenuItem<Bovine>(
                                      value: item, child: Text(item.name!)))
                                  .toList(),
                              onChanged: (value) {
                                dad = value;
                              }),
                    ))),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _breedController.dispose();
    _weightController.dispose();
    _descriptionController.dispose();
    _birthController.dispose();
    super.dispose();
  }

  void _saveBovine() async {
    String birthString = _birthController.text;
    DateTime birthDate;
    try {
      DateFormat format = DateFormat("dd/MM/yyyy");
      birthDate = format.parse(birthString);
    } catch (e) {
      print("Erro ao converter a data: $e");
      return;
    }

    if(_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Aguarde');
      try {
        final bovine = Bovine(
          name: _nameController.text,
          status: bovineStatus, 
          gender: bovineGender, 
          breed: _breedController.text,
          herd: herd!,
          weight: num.parse(_weightController.text),
          birth: birthDate,
          dad: null,
          mom: null,
          description: _descriptionController.text,
          );
          await Provider.of<BovineProvider>(context, listen: false)
          .addBovine(bovine);
          EasyLoading.dismiss();
          showMsg(context, 'Salvo');
          _resetFields();
      } catch(error) {
        EasyLoading.dismiss();
        print(error.toString());
      }
    }
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(

      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100)
    );

    if(_picked != null) {
      setState(() {
        _birthController.text = _picked.toString().split(" ")[0];
      });
    }
  }
  
  void _resetFields() {
    setState(() {
      _nameController.clear();
      _breedController.clear();
      _weightController.clear();
      _descriptionController.clear();
      _birthController.clear();
      dad = null;
      mom = null;
      herd = null;
      bovineGender = BovineUtils.genderList.first;
      bovineStatus = BovineUtils.statusList.first;
    });
  }
}
