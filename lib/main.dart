import 'package:ecopos/data/bloc/bloc/main_bloc.dart';
import 'package:ecopos/data/bloc/bloc/product/product_bloc.dart';
// import 'package:ecopos/data/bloc/bloc/profile/profile_bloc.dart';
import 'package:ecopos/main/main_screen.dart';
import 'package:ecopos/pages/product/datasource/product_remote_datasource.dart';
import 'package:ecopos/pages/product/product_list_page.dart';
// import 'package:ecopos/pages/profile/datasource/profile_remote_datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                ProductBloc(remoteDatasource: ProductRemoteDatasource())
                  ..add(FetchProducts()),
            child: ProductListPage(),
          ),

          // BlocProvider(
          //   create: (_) => ProfileBloc(ProfileRemoteDatasource()),
          // ),
          BlocProvider(
            create: (_) => MainBloc(), // tambahkan jika kamu memakai MainBloc
          ),
          // Tambahkan bloc lainnya di sini kalau ada
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const AuthPage(),
        ),
      ),
    );
  }
}
