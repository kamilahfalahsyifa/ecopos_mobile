import 'package:ecopos/config/ColorConfig.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConfig.bgLight,
      appBar: AppBar(
        title: const Text("Product Screen "),
        backgroundColor: ColorConfig.bgLight,
      ),
      body: const Center(
        child: Text("Hello From Product Screen"),
      ),
    );
  }
}
