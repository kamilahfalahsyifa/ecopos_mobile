import 'package:ecopos/main/bloc/main_bloc.dart';
import 'package:ecopos/main/bloc/profile/profile_bloc.dart';
import 'package:ecopos/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecopos/config/ColorConfig.dart';
import 'package:ecopos/main/bloc/product/product_bloc.dart';
import 'package:ecopos/services/product_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // TODO: Ganti placeholder ini dengan ID Outlet yang sebenarnya dari aplikasi Anda.
  // Ini bisa didapatkan dari data login pengguna, konfigurasi aplikasi, dll.
  final String _initialOutletId =
      '426c196f-ea5b-4bf1-a084-ad22d087b48c'; // Contoh dari Postman Collection

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
  providers: [
    BlocProvider<MainBloc>(
      create: (context) => MainBloc(),
    ),
    BlocProvider<ProductBloc>(
      create: (context) =>
          ProductBloc(ProductService())..add(FetchProducts(_initialOutletId)),
    ),
    BlocProvider<ProfileBloc>(
      create: (context) => ProfileBloc()..add(LoadProfile()),
    ),
  ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ecopos',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
          ),
        ),
        home: const MainScreen(),
      ),
    );
  }
}
