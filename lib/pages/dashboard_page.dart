import 'package:flutter/material.dart';
import 'package:gadoapp/auth/auth_service.dart';
import 'package:gadoapp/customwidgets/dashboard_item_view.dart';
import 'package:gadoapp/main.dart';
import 'package:gadoapp/models/dashboard_model.dart';
import 'package:gadoapp/pages/login_page.dart';
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
  @override
  void didChangeDependencies() {
    Provider.of<BovineProvider>(context, listen: false).getAllHerds();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Painel'),
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
      body: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: dashboardModelList.length,
        itemBuilder: (context, index) {
          final model = dashboardModelList[index];
          return DashboardItemView(
            model: model,
            onPress: (route) {
              context.goNamed(route);
            },
          );
        },
      ),
    );
  }
}
