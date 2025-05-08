import 'package:ecopos/data/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecopos/screen/login_screen.dart';
import 'package:ecopos/screen/signup_screen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool a = true;
  void go() {
    setState(() {
      a = !a;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (a) {
      return BlocProvider(
        create: (context) => AuthBloc(),
        child: LoginScreen(show: go),
      );
    } else {
      return BlocProvider(
        create: (context) => AuthBloc(),
        child: SignUpScreen(show: go),
      );
    }
  }
}