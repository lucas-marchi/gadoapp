import 'package:flutter/material.dart';
import 'package:gadoapp/auth/auth_service.dart';
import 'package:gadoapp/customwidgets/dashboard_item_view.dart';
import 'package:gadoapp/models/dashboard_model.dart';
import 'package:gadoapp/pages/herd_page.dart';
import 'package:gadoapp/pages/login_page.dart';
import 'package:gadoapp/pages/view_bovine_page.dart';
import 'package:gadoapp/providers/bovine_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  static const String routeName = '/';
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  @override
  void didChangeDependencies() {
    Provider.of<BovineProvider>(context, listen: false).getAllHerds();
    Provider.of<BovineProvider>(context, listen: false).getAllBovines();
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Rebanhos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
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
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Total de Rebanhos: $herdCount'),
                Text('Total de Animais: $bovineCount'),
              ],
            ),
          );
        },
      );
    case 1:
      return const HerdPage();
    case 2:
      return const ViewBovinePage();
    default:
      return const Center(child: Text('Erro: Aba inválida'));
  }
}

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
