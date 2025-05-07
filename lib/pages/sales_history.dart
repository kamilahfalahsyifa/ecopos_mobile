import 'package:ecopos/config/ColorConfig.dart';
import 'package:flutter/material.dart';

class SellingScreen extends StatelessWidget {
  const SellingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConfig.bgLight,
      appBar: AppBar(
        title: const Text("Selling History Screen "),
        backgroundColor: ColorConfig.bgLight,
      ),
      body: const Center(
        child: Text("Hello From Selling History Screen"),
      ),
    );
  }
}
