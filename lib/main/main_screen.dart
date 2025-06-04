import 'package:ecopos/config/ColorConfig.dart';
import 'package:ecopos/pages/dashboard.dart';
import 'package:ecopos/pages/pos.dart';
import 'package:ecopos/pages/profile.dart';
import 'package:ecopos/pages/product_screen/product_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecopos/main/bloc/main_bloc.dart';

List<Widget> _bodyItems = [
  const DashboardScreen(),
  const POSScreen(),
  ProductListPage(),
  const ProfileScreen(),
];

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: _bodyItems[state.tabIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: "Dashboard"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart_rounded), label: "POS"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.inventory_2), label: "Product"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile"),
            ],
            currentIndex: state.tabIndex,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Colors.black45,
            onTap: (index) {
              BlocProvider.of<MainBloc>(context).add(ChangeTabEvent(index));
            },
          ),
        );
      },
    );
  }
}
