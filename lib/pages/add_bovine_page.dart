import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gadoapp/customwidgets/radio_group.dart';
import 'package:gadoapp/models/bovine.dart';
import 'package:gadoapp/models/herd.dart';
import 'package:gadoapp/services/database_service.dart';
import 'package:gadoapp/utils/constants.dart';
import 'package:gadoapp/utils/widget_functions.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

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
  final DatabaseService _databaseService = DatabaseService.instance;

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
              padding: const EdgeInsets.only(bottom: 16),
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(5.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                    borderRadius: BorderRadius.circular(5.5),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.secondary,
                  labelText: 'Nome ou brinco:',
                  labelStyle:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
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
              padding: const EdgeInsets.only(bottom: 16),
              child: TextFormField(
                controller: _breedController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(5.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                    borderRadius: BorderRadius.circular(5.5),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.secondary,
                  labelText: 'Raça:',
                  labelStyle:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: RadioGroup(
                  label: 'Status:',
                  groupValue: bovineStatus,
                  items: BovineUtils.statusList,
                  onItemSelected: (value) {
                    bovineStatus = value;
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _weightController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(5.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                    borderRadius: BorderRadius.circular(5.5),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.secondary,
                  labelText: 'Peso:',
                  labelStyle:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _birthController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(5.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                    borderRadius: BorderRadius.circular(5.5),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.secondary,
                  labelStyle:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                  border: InputBorder.none,
                  labelText: 'Data de nascimento:',
                  prefixIcon: const Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () {
                  _selectDate();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: RadioGroup(
                  label: 'Sexo:',
                  groupValue: bovineGender,
                  items: BovineUtils.genderList,
                  onItemSelected: (value) {
                    bovineGender = value;
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(5.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                    borderRadius: BorderRadius.circular(5.5),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.secondary,
                  labelText: 'Observação:',
                  labelStyle:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.5),
                ),
                elevation: 0,
                margin: const EdgeInsets.all(0.0),
                color: Theme.of(context).colorScheme.secondary,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder<List<Herd>>(
                    future: _databaseService.getHerds(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return DropdownButtonFormField<Herd>(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Carregando rebanhos...',
                          ),
                          items: const [],
                          onChanged: (_) {},
                        );
                      }
                      return DropdownButtonFormField<Herd>(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Rebanho:',
                        ),
                        hint: const Text('Selecione um rebanho'),
                        isExpanded: true,
                        value: herd,
                        items: snapshot.data!
                            .map((item) => DropdownMenuItem<Herd>(
                                  // Removido const
                                  value: item,
                                  child: Text(item.name),
                                ))
                            .toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Selecione para qual rebanho será adicionado';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() => herd = value);
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.5),
                ),
                elevation: 0,
                margin: const EdgeInsets.all(0.0),
                color: Theme.of(context).colorScheme.secondary,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder<List<Bovine>>(
                    future: _databaseService.getBovines(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return DropdownButtonFormField<Bovine>(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Carregando bovinos...',
                          ),
                          items: const [],
                          onChanged: (_) {},
                        );
                      }
                      final males = snapshot.data!
                          .where((b) => b.gender == 'Macho')
                          .toList();
                      return DropdownButtonFormField<Bovine>(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Pai:',
                        ),
                        hint: const Text('Não informar'),
                        isExpanded: true,
                        value: dad,
                        items: males
                            .map((item) => DropdownMenuItem<Bovine>(
                                  // Removido const
                                  value: item,
                                  child: Text(item.name),
                                ))
                            .toList(),
                        onChanged: (value) {
                          // Garantir onChanged
                          setState(() => dad = value);
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.5),
                ),
                elevation: 0,
                margin: const EdgeInsets.all(0.0),
                color: Theme.of(context).colorScheme.secondary,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder<List<Bovine>>(
                    future: _databaseService.getBovines(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return DropdownButtonFormField(
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Carregando bovinos...'),
                          items: const [],
                          onChanged: (_) {},
                        );
                      }
                      final females = snapshot.data!
                          .where((b) => b.gender == 'Fêmea')
                          .toList();
                      return DropdownButtonFormField<Bovine>(
                        decoration: const InputDecoration(
                            border: InputBorder.none, labelText: 'Mãe:'),
                        hint: const Text('Não informar'),
                        isExpanded: true,
                        value: mom,
                        items: females
                            .map((item) => DropdownMenuItem<Bovine>(
                                  value: item,
                                  child: Text(item.name),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() => mom = value);
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
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
    if (_formKey.currentState!.validate()) {
      try {
        EasyLoading.show(status: 'Salvando...');

        // Converter dados
        final birthDate = _birthController.text.isNotEmpty
            ? DateTime.parse(_birthController.text)
            : DateTime.now();

        // Obter IDs
        final herdId = herd?.id ?? 0;
        final momId = mom?.id;
        final dadId = dad?.id;

        if (herdId <= 0) {
          throw Exception('Selecione um rebanho válido');
        }

        final weight = _weightController.text.isNotEmpty
            ? double.parse(_weightController.text)
            : 0.0;

        _databaseService.addBovine(
          _nameController.text,
          bovineStatus,
          bovineGender,
          _breedController.text,
          weight,
          birthDate.toIso8601String(), // Converter para string ISO
          herdId,
          momId!,
          dadId!,
          _descriptionController.text,
        );

        EasyLoading.dismiss();
        showMsg(context, 'Bovino cadastrado com sucesso!');
        _resetFields();
      } on FormatException catch (e) {
        EasyLoading.dismiss();
        showMsg(context, 'Erro de formato: ${e.message}');
      } on DatabaseException catch (e) {
        EasyLoading.dismiss();
        showMsg(context, 'Erro no banco: $e');
      } catch (e) {
        EasyLoading.dismiss();
        showMsg(context, 'Erro inesperado: $e');
      }
    }
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      locale: const Locale('pt', 'PT'),
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _birthController.text = picked.toString().split(" ")[0];
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
