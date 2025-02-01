import 'package:flutter/material.dart';
import 'package:gadoapp/models/bovine.dart';
import 'package:gadoapp/pages/add_bovine_page.dart';
import 'package:gadoapp/pages/bovine_details_page.dart';
import 'package:gadoapp/providers/bovine_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ViewBovinePage extends StatefulWidget {
  static const String routeName = 'viewbovine';
  const ViewBovinePage({super.key});

  @override
  State<ViewBovinePage> createState() => _ViewBovinePageState();
}

class _ViewBovinePageState extends State<ViewBovinePage> {
  final _searchController = TextEditingController();
  String _searchText = '';
  String? _selectedHerdId;
  String? _selectedGender;
  String? _selectedStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _searchText = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Pesquisar',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                _showFilterDialog(context);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed(AddBovinePage.routeName);
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<BovineProvider>(builder: (context, provider, child) {
        final filteredBovines = provider.bovineList
            .where((bovine) =>
                bovine.name!
                    .toLowerCase()
                    .contains(_searchText.toLowerCase()) &&
                (_selectedHerdId == null ||
                    bovine.herd?.id == _selectedHerdId) &&
                (_selectedGender == null || bovine.gender == _selectedGender) &&
                (_selectedStatus == null || bovine.status == _selectedStatus))
            .toList();
        return filteredBovines.isEmpty
            ? const Center(
                child: Text('Nenhum bovino encontrado'),
              )
            : ListView.builder(
                itemCount: filteredBovines.length,
                itemBuilder: (context, index) {
                  final bovine = filteredBovines[index];
                  return InkWell(
                    onTap: () {
                      context.goNamed(BovineDetailsPage.routeName,
                          extra: bovine.id);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
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
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      bovine.name!,
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Row(
                                      children: [
                                        const Icon(Icons.circle_outlined,
                                            color: Colors.grey, size: 18.0),
                                        const SizedBox(width: 4.0),
                                        Text(
                                          bovine.breed!,
                                          style: const TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.grey),
                                        ),
                                        const SizedBox(
                                            width:
                                                16.0), // Espaçamento entre raça e ícone de status
                                        _getStatusIcon(bovine.status),
                                        const SizedBox(
                                            width:
                                                4.0), // Espaçamento entre ícone e texto do status
                                        Text(
                                          bovine.status,
                                          style: const TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Builder(
                                builder: (BuildContext context) {
                                  return Icon(
                                    Icons.chevron_right,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
      }),
    );
  }

  Widget _getStatusIcon(String? status) {
    switch (status) {
      case 'Vivo':
        return const Icon(Icons.favorite_rounded,
            color: Colors.grey, size: 18.0);
      case 'Morto':
        return const Icon(Icons.heart_broken_rounded,
            color: Colors.grey, size: 18.0);
      case 'Vendido':
        return const Icon(Icons.attach_money_rounded,
            color: Colors.grey, size: 18.0);
      default:
        return const Icon(Icons.question_mark_rounded,
            color: Colors.grey, size: 18.0);
    }
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filtros'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Rebanho'),
                value: _selectedHerdId,
                items: _herdDropdownItems(context),
                onChanged: (value) {
                  setState(() {
                    _selectedHerdId = value;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Sexo'),
                value: _selectedGender,
                items: _sexDropdownItems(),
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Status'),
                value: _selectedStatus,
                items: _statusDropdownItems(),
                onChanged: (value) {
                  setState(() {
                    _selectedStatus = value;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Aplicar'),
              onPressed: () {
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<Bovine> _filterBovines(List<Bovine> bovines) {
    return bovines
        .where((bovine) =>
            bovine.name!.toLowerCase().contains(_searchText.toLowerCase()) &&
            (_selectedHerdId == null || bovine.herd?.id == _selectedHerdId) &&
            (_selectedGender == null || bovine.gender == _selectedGender) &&
            (_selectedStatus == null || bovine.status == _selectedStatus))
        .toList();
  }

  List<DropdownMenuItem<String>> _herdDropdownItems(BuildContext context) {
    final provider = Provider.of<BovineProvider>(context, listen: false);
    return provider.herdList.map((herd) {
      return DropdownMenuItem(
        value: herd.id,
        child: Text(herd.name),
      );
    }).toList();
  }

  List<DropdownMenuItem<String>> _sexDropdownItems() {
    return ['Macho', 'Fêmea'].map((sex) {
      return DropdownMenuItem(
        value: sex,
        child: Text(sex),
      );
    }).toList();
  }

  List<DropdownMenuItem<String>> _statusDropdownItems() {
    return ['Vivo', 'Morto', 'Vendido'].map((status) {
      return DropdownMenuItem(
        value: status,
        child: Text(status),
      );
    }).toList();
  }
}
