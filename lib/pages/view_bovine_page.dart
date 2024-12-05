import 'package:flutter/material.dart';
import 'package:gadoapp/main.dart';
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
      appBar: AppBar(title: const Text("Bovinos"),),
      body: Center(
        child: Consumer<BovineProvider>(
          builder: (context, provider, child) => ListView.builder(
            itemCount: provider.bovineList.length,
            itemBuilder: (context, index) {
              final bovine = provider.bovineList[index];
              return InkWell(
                onTap: () {
                  context.goNamed(BovineDetailsPage.routeName, extra: bovine.id);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Card(
                    color: Color.fromRGBO(222, 227, 227, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 0,
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(bovine.name!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                              ],
                            ),
                          )
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(bovine.gender, style: const TextStyle(fontSize: 16,),),
                              ],
                            ),
                          )
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(bovine.breed!, style: const TextStyle(fontSize: 16,),),
                              ],
                            ),
                          )
                        )
                      ],
                    ),
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