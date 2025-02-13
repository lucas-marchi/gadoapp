import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gadoapp/models/herd.dart';
import 'package:gadoapp/pages/view_bovine_page.dart';
import 'package:gadoapp/providers/bovine_provider.dart';
import 'package:gadoapp/services/database_service.dart';
import 'package:gadoapp/utils/widget_functions.dart';
import 'package:provider/provider.dart';

class HerdPage extends StatefulWidget {
  static const String routeName = 'herd';

  const HerdPage({super.key});

  @override
  State<HerdPage> createState() => _HerdPageState();
}

class _HerdPageState extends State<HerdPage> {
  final DatabaseService _databaseService = DatabaseService.instance;

  String? _herd = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSingleTextInputDialog(
            context: context,
            title: 'Adicionar Rebanho',
            onSubmit: (value) {
              _herd = value;
              if (_herd == null || _herd == "") return;
              _databaseService.addHerd(_herd!);
              setState(() {});
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: _herdsList(),
      //
      // Consumer<BovineProvider>(
      //   builder: (context, provider, child) => provider.herdList.isEmpty
      //       ? const Center(
      //           child: Text('Nenhum rebanho encontrado'),
      //         )
      //       : ListView.builder(
      //           itemCount: provider.herdList.length,
      //           itemBuilder: (context, index) {
      //             final herd = provider.herdList[index];
      //             final bovineCount = provider.bovineList
      //                 .where((bovine) => bovine.herd?.id == herd.id)
      //                 .length;

      //             return InkWell(
      //               onTap: () {
      //                 final filteredBovines = provider.bovineList
      //                     .where((bovine) => bovine.herd!.id == herd.id)
      //                     .toList();
      //                 Navigator.of(context).pushNamed(
      //                   ViewBovinePage.routeName,
      //                   arguments: filteredBovines,
      //                 );
      //               },
      //               child: Padding(
      //                 padding: const EdgeInsets.symmetric(
      //                     horizontal: 16.0, vertical: 8.0),
      //                 child: Card(
      //                   elevation: 4.0,
      //                   color: Theme.of(context).colorScheme.secondaryContainer,
      //                   shape: RoundedRectangleBorder(
      //                     borderRadius: BorderRadius.circular(16.0),
      //                   ),
      //                   child: Padding(
      //                     padding: const EdgeInsets.all(16.0),
      //                     child: Row(
      //                       children: [
      //                         Expanded(
      //                           child: Column(
      //                             crossAxisAlignment: CrossAxisAlignment.start,
      //                             children: [
      //                               Text(
      //                                 herd.name,
      //                                 style: const TextStyle(
      //                                   fontSize: 18.0,
      //                                   fontWeight: FontWeight.w500,
      //                                 ),
      //                               ),
      //                               const SizedBox(height: 4.0),
      //                               Text(
      //                                 '$bovineCount cabeças',
      //                                 style: const TextStyle(
      //                                     fontSize: 16.0, color: Colors.grey),
      //                               ),
      //                             ],
      //                           ),
      //                         ),
      //                         Builder(
      //                           builder: (BuildContext context) {
      //                             return Icon(
      //                               Icons.chevron_right,
      //                               color: Theme.of(context).colorScheme.primary,
      //                             );
      //                           },
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             );
      //           },
      //         ),
      // ),
    );
  }

  Widget _herdsList() {
    return FutureBuilder(
      future: _databaseService.getHerds(),
      builder: (context, snapshot) {
        return ListView.builder(
          itemCount: snapshot.data?.length ?? 0,
          itemBuilder: (context, index) {
            Herd herd = snapshot.data![index];
            return ListTile(
              onLongPress: () {
                _databaseService.deleteHerd(herd.id);
                setState(() {});
              },
              title: Text(
              herd.name,
            ),
            );
          },
        );
      },
    );
  }
}
