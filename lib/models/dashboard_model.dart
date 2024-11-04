import 'package:flutter/material.dart';
import 'package:gadoapp/pages/add_bovine_page.dart';
import 'package:gadoapp/pages/herd_page.dart';
import 'package:gadoapp/pages/view_bovine_page.dart';

class DashboardModel {
  final String title;
  final IconData;
  final String routeName;

  const DashboardModel({
    required this.title,
    required this.IconData,
    required this.routeName
  });
}

const List<DashboardModel> dashboardModelList = [
  DashboardModel(title: 'Adicionar bovino', IconData: Icons.add, routeName: AddBovinePage.routeName),
  DashboardModel(title: 'Visualizar bovino', IconData: Icons.inventory, routeName: ViewBovinePage.routeName),
  DashboardModel(title: 'Rebanhos', IconData: Icons.category, routeName: HerdPage.routeName),
];