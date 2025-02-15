import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gadoapp/auth/auth_service.dart';
import 'package:gadoapp/models/bovine.dart';
import 'package:gadoapp/models/herd.dart';
import 'package:gadoapp/pages/herd_page.dart';
import 'package:gadoapp/pages/login_page.dart';
import 'package:gadoapp/pages/view_bovine_page.dart';
import 'package:gadoapp/services/api_service.dart';
import 'package:gadoapp/services/database_service.dart';
import 'package:go_router/go_router.dart';

class DashboardPage extends StatefulWidget {
  static const String routeName = '/';
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final DatabaseService _databaseService = DatabaseService.instance;
  final ApiService _apiService = ApiService();
  final ValueNotifier<bool> _syncStatus = ValueNotifier(false);
  DateTime? _lastSync;

  int _selectedIndex = 0;
  late Future<List<Herd>> _herdsFuture;
  late Future<List<Bovine>> _bovinesFuture;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    _loadSyncStatus();
    _refreshData();
  }

  void _loadSyncStatus() async {
    try {
      _lastSync = await _apiService.getLastSync();
      _syncStatus.value = _lastSync != null;
    } catch (e) {
      print('Erro ao carregar status de sincronização: $e');
    }
  }

  void _refreshData() {
    setState(() {
      _herdsFuture = _databaseService.getHerds().catchError((error) {
        print('Erro ao carregar rebanhos: $error');
        return <Herd>[];
      });

      _bovinesFuture = _databaseService.getBovines().catchError((error) {
        print('Erro ao carregar bovinos: $error');
        return <Bovine>[];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GadoApp'),
        actions: [
          ValueListenableBuilder<bool>(
            valueListenable: _syncStatus,
            builder: (context, isSynced, _) {
              return IconButton(
                icon: Icon(
                  isSynced ? Icons.cloud_done : Icons.cloud_off,
                  color: isSynced ? Colors.green : Colors.red,
                ),
                onPressed: () {
                  if (!isSynced) {
                    _performSync();
                  } else {
                    EasyLoading.showInfo('Já está sincronizado!');
                  }
                },
              );
            },
          ),
          IconButton(
            onPressed: () {
              AuthService.logout()
                  .then((value) => context.goNamed(LoginPage.routeName));
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grass),
            label: 'Rebanhos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Animais',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        ValueListenableBuilder<bool>(
          valueListenable: _syncStatus,
          builder: (context, isSynced, _) {
            if (isSynced) return const SizedBox.shrink();

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.sync),
                label: const Text('Sincronizar Dados'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
                onPressed: _performSync,
              ),
            );
          },
        );
        return FutureBuilder(
          future: Future.wait([_herdsFuture, _bovinesFuture]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('Erro: ${snapshot.error}'),
              );
            }

            final herds = snapshot.data?[0] as List<Herd>? ?? [];
            final bovines = snapshot.data?[1] as List<Bovine>? ?? [];
            final bovinesSold =
                bovines.where((b) => b.status == 'Vendido').length;

            return Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Card(
                  elevation: 4,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    // Agora é o child do Card
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildInfoRow('Rebanhos', herds.length),
                        const SizedBox(height: 16),
                        _buildInfoRow('Número de cabeças', bovines.length),
                        const SizedBox(height: 16),
                        _buildInfoRow('Vendidos', bovinesSold),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      case 1:
        return HerdPage(onUpdate: _refreshData);
      case 2:
        return const ViewBovinePage();
      default:
        return const Center(child: Text('Erro: Aba inválida'));
    }
  }

  Widget _buildInfoRow(String label, int value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  void _onItemTapped(int index) {
    if (index == 0) _refreshData();
    setState(() => _selectedIndex = index);
  }

  Future<void> _performSync() async {
    EasyLoading.show(status: 'Sincronizando...');
    try {
      final herds = await _databaseService.getHerds();
      final bovines = await _databaseService.getBovines();

      print("Aquiiii: $herds, $bovines");

      final success = await _apiService.syncData(herds, bovines);

      if (success) {
        EasyLoading.showSuccess('Dados sincronizados!');
        _syncStatus.value = true;
        _loadSyncStatus();
      } else {
        EasyLoading.showError('Falha na sincronização');
      }
    } catch (e) {
      EasyLoading.showError('Erro: ${e.toString()}');
    } finally {
      EasyLoading.dismiss();
    }
  }
}
