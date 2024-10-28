import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gadoapp/auth/auth_service.dart';
import 'package:gadoapp/main.dart';
import 'package:gadoapp/pages/dashboard_page.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errMsg = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(24.0),
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: const InputDecoration(
                    filled: true,
                    prefixIcon: Icon(Icons.email),
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return 'Insida um email válido';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    filled: true,
                    prefixIcon: Icon(Icons.password),
                    labelText: 'Senha (no mínimo 6 caracteres)',
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return 'Insida uma senha válida';
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: _authenticate,
                child: const Text('Entrar como administrador'),
              ),
              Text(_errMsg, style: const TextStyle(fontSize: 18, color: Colors.red),),
            ],
          )
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _authenticate() async {
    if(_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Aguarde...');
      final email = _emailController.text;
      final pass = _passwordController.text;
      try {
        final status = await AuthService.loginAdmin(email, pass);
        EasyLoading.dismiss();
        if(status) {
          context.goNamed(DashboardPage.routeName);
        } else {
          await AuthService.logout();
          setState(() {
            _errMsg = 'Este usuário não é um Administrador';
          });
        }
      } on FirebaseAuthException catch(error) {
        EasyLoading.dismiss();
        setState(() {
          _errMsg = error.message!;
        });
      }
    }
  }
}