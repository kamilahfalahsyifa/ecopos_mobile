import 'dart:convert';

import 'package:ecopos/pages/product/models/product_response_model.dart';
import 'package:ecopos/util/auth_manager.dart';
import 'package:http/http.dart' as http;

class CategoryRemoteDatasource {
  Future<List<Category>> fetchCategories() async {
    final String baseUrl = 'https://tannn.my.id/api';
    final token = AuthManager.readAuth();
    final outletId = AuthManager.getOutlet();

    final response = await http.get(
      Uri.parse('$baseUrl/outlets/$outletId/categories'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final categories = jsonData['categories'] as List;
      return categories.map((e) => Category.fromJson(e)).toList();
    } else {
      throw Exception('Gagal mengambil kategori');
    }
  }
}
