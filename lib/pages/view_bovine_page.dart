import 'package:flutter/material.dart';
import 'package:gadoapp/main.dart';
import 'package:gadoapp/pages/bovine_details_page.dart';
import 'package:gadoapp/providers/bovine_provider.dart';
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
      appBar: AppBar(title: const Text("Bovinos"),),
      body: Center(
        child: Consumer<BovineProvider>(
          builder: (context, provider, child) => ListView.builder(
            itemCount: provider.bovineList.length,
            itemBuilder: (context, index) {
              final bovine = provider.bovineList[index];
              return InkWell(
                onTap: () {
                  //context.goNamed(BovineDetailsPage.routeName, extra: bovine.id);
                },
                child: Card(
                  elevation: 0,
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(bovine.name!, style: const TextStyle(fontSize: 16,),),
                              Text(bovine.breed!, style: const TextStyle(color: Colors.grey, overflow: TextOverflow.ellipsis),)
                            ],
                          ),
                        )
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}