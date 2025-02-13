import 'package:flutter/material.dart';
import 'package:gadoapp/auth/auth_service.dart';
import 'package:gadoapp/pages/herd_page.dart';
import 'package:gadoapp/pages/login_page.dart';
import 'package:gadoapp/pages/view_bovine_page.dart';
import 'package:gadoapp/providers/bovine_provider.dart';
import 'package:gadoapp/services/database_service.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  static const String routeName = '/';
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  
  final DatabaseService _databaseService = DatabaseService.instance;

  int _selectedIndex = 0;

  @override
  void didChangeDependencies() {
    //Provider.of<BovineProvider>(context, listen: false).getAllHerds();
    //Provider.of<BovineProvider>(context, listen: false).getAllBovines();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GadoApp'),
        actions: [
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
        return Consumer<BovineProvider>(
          builder: (context, provider, child) {
            final herdCount = provider.herdList.length;
            final bovineCount = provider.bovineList.length;
            final bovinesSold = provider.bovineList
                .where((bovine) => bovine.status == 'Vendido')
                .length;

            return Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Card(
                  elevation: 4,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildInfoRow('Rebanhos', herdCount),
                        const SizedBox(height: 16),
                        _buildInfoRow('Número de cabeças', bovineCount),
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
        return HerdPage();
      case 2:
        return const ViewBovinePage();
      default:
        return const Center(child: Text('Erro: Aba inválida'));
    }
  }

  Widget _buildInfoRow(String label, int value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment
          .spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500), // Estilo do rótulo
        ),
        Text(
          value.toString(),
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold), // Estilo do valor
        ),
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
