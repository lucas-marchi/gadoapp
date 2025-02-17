import 'package:flutter/material.dart';
import 'package:gadoapp/models/bovine.dart';
import 'package:gadoapp/models/herd.dart';
import 'package:gadoapp/pages/add_bovine_page.dart';
import 'package:gadoapp/pages/bovine_details_page.dart';
import 'package:gadoapp/services/database_service.dart';
import 'package:go_router/go_router.dart';

class ViewBovinePage extends StatefulWidget {
  static const String routeName = 'viewbovine';
  const ViewBovinePage({super.key});

  @override
  State<ViewBovinePage> createState() => _ViewBovinePageState();
}

class _ViewBovinePageState extends State<ViewBovinePage> {
  final _searchController = TextEditingController();
  final DatabaseService _databaseService = DatabaseService.instance;
  String _searchText = '';
  int? _selectedHerdId;
  String? _selectedGender;
  String? _selectedStatus;
  List<Bovine> _bovines = [];
  List<Herd> _herds = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    //final bovines = await _databaseService.getBovines();
    final herds = await _databaseService.getHerds();
    setState(() {
      //_bovines = bovines;
      _herds = herds;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                onChanged: (value) => setState(() => _searchText = value),
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
              onPressed: () => _showFilterDialog(context),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.goNamed(AddBovinePage.routeName),
        child: const Icon(Icons.add),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    final filteredBovines = _filterBovines(_bovines);
    
    return filteredBovines.isEmpty
        ? const Center(child: Text('Nenhum bovino encontrado'))
        : ListView.builder(
            itemCount: filteredBovines.length,
            itemBuilder: (context, index) {
              final bovine = filteredBovines[index];
              return _buildBovineCard(bovine);
            },
          );
  }

  Widget _buildBovineCard(Bovine bovine) {
    return InkWell(
      onTap: () => context.goNamed(BovineDetailsPage.routeName, extra: bovine.id),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                        bovine.name,
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
                            bovine.breed ?? 'Raça não informada',
                            style: const TextStyle(
                                fontSize: 16.0, color: Colors.grey),
                          ),
                          const SizedBox(width: 16.0),
                          _getStatusIcon(bovine.status),
                          const SizedBox(width: 4.0),
                          Text(
                            bovine.status,
                            style: const TextStyle(
                                fontSize: 16.0, color: Colors.grey),
                          ),
                        ],
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
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filtros'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Rebanho'),
              value: _selectedHerdId.toString(),
              items: _herds
                  .map((herd) => DropdownMenuItem(
                        value: herd.id.toString(),
                        child: Text(herd.name),
                      ))
                  .toList(),
              onChanged: (value) => setState(() => _selectedHerdId = value as int?),
            ),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Sexo'),
              value: _selectedGender,
              items: ['Macho', 'Fêmea']
                  .map((sex) => DropdownMenuItem(
                        value: sex,
                        child: Text(sex),
                      ))
                  .toList(),
              onChanged: (value) => setState(() => _selectedGender = value),
            ),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Status'),
              value: _selectedStatus,
              items: ['Vivo', 'Morto', 'Vendido']
                  .map((status) => DropdownMenuItem(
                        value: status,
                        child: Text(status),
                      ))
                  .toList(),
              onChanged: (value) => setState(() => _selectedStatus = value),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {});
              Navigator.of(context).pop();
            },
            child: const Text('Aplicar'),
          ),
        ],
      ),
    );
  }

  List<Bovine> _filterBovines(List<Bovine> bovines) {
    return bovines.where((bovine) {
      final nameMatch = bovine.name.toLowerCase().contains(_searchText.toLowerCase());
      final herdMatch = _selectedHerdId == null || 
          bovine.herdId == _selectedHerdId;
      final genderMatch = _selectedGender == null || 
          bovine.gender == _selectedGender;
      final statusMatch = _selectedStatus == null || 
          bovine.status == _selectedStatus;
      
      return nameMatch && herdMatch && genderMatch && statusMatch;
    }).toList();
  }

  Widget _getStatusIcon(String status) {
    switch (status) {
      case 'Vivo':
        return const Icon(Icons.favorite_rounded, color: Colors.grey, size: 18.0);
      case 'Morto':
        return const Icon(Icons.heart_broken_rounded, color: Colors.grey, size: 18.0);
      case 'Vendido':
        return const Icon(Icons.attach_money_rounded, color: Colors.grey, size: 18.0);
      default:
        return const Icon(Icons.question_mark_rounded, color: Colors.grey, size: 18.0);
    }
  }
}