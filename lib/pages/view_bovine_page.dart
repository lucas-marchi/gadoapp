import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed(AddBovinePage.routeName);
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<BovineProvider>(
        builder: (context, provider, child) => provider.bovineList.isEmpty
            ? const Center(
                child: Text('Nenhum bovino encontrado'),
              )
            : ListView.builder(
                itemCount: provider.bovineList.length,
                itemBuilder: (context, index) {
                  final bovine = provider.bovineList[index];
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
                                flex: 2, // Aumenta o espaço para o nome
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
              ),
      ),
    );
  }

  Widget _getStatusIcon(String? status) {
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
