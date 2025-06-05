import 'package:ecopos/main/bloc/main_bloc.dart';
import 'package:ecopos/main/bloc/profile/profile_bloc.dart';
import 'package:ecopos/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecopos/auth/auth.dart';
import 'package:ecopos/gitit/gitit.dart';
import 'package:ecopos/screen/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getItInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(430, 932),
        child:
          MaterialApp(debugShowCheckedModeBanner: false, home: AuthPage()));
  }
}