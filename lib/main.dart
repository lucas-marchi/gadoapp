import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gadoapp/auth/auth_service.dart';
import 'package:gadoapp/pages/add_bovine_page.dart';
import 'package:gadoapp/pages/bovine_details_page.dart';
import 'package:gadoapp/pages/dashboard_page.dart';
import 'package:gadoapp/pages/herd_page.dart';
import 'package:gadoapp/pages/view_bovine_page.dart';
import 'package:gadoapp/providers/bovine_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:gadoapp/pages/login_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

    options: DefaultFirebaseOptions.currentPlatform,

  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => BovineProvider()),
    ],
    child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'gadoapp',
      builder: EasyLoading.init(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      routerConfig: _router,

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('pt')
      ],
    );
  }

  final _router = GoRouter(
    initialLocation: DashboardPage.routeName,
    redirect: (context, state) {
      if(AuthService.currentUser == null) {
        return LoginPage.routeName;
      }
      return null;
    },
    routes: [
      GoRoute(
        name: DashboardPage.routeName,
        path: DashboardPage.routeName,
        builder: (context, state) => const DashboardPage(),
        routes: [
          GoRoute(
            name: AddBovinePage.routeName,
            path: AddBovinePage.routeName,
            builder: (context, state) => const AddBovinePage()
          ),
          GoRoute(
            name: ViewBovinePage.routeName,
            path: ViewBovinePage.routeName,
            builder: (context, state) => const ViewBovinePage(),
            routes: [
              GoRoute(
                name: BovineDetailsPage.routeName,
                path: BovineDetailsPage.routeName,
                builder: (context, state) => BovineDetailsPage(id: state.extra! as String,),
              )
            ]
          ),
          GoRoute(
            name: HerdPage.routeName,
            path: HerdPage.routeName,
            builder: (context, state) => const HerdPage()
          ),
        ],
      ),
      GoRoute(
        name: LoginPage.routeName,
        path: LoginPage.routeName,
        builder: (context, state) => const LoginPage()
      )
    ]
  );
}