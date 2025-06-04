import 'dart:convert';
import 'package:ecopos/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductService {
  final String baseUrl = "https://tannn.my.id/api";

  final String _apiToken = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3Rhbm5uLm15LmlkL2FwaS9sb2dpbiIsImlhdCI6MTc0ODk2MTQ5MywiZXhwIjoxNzQ4OTY1MDkzLCJuYmYiOjE3NDg5NjE0OTMsImp0aSI6ImVkU3J4MmdId1A5WlNlbEsiLCJzdWIiOiJiYTQxODNjNy01YTcwLTQxZGItYjIwMS0zMzJkZWI0NGI3MDIiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3IiwidXVpZCI6bnVsbCwiZW1haWwiOiJzdXBlcmFkbWluQHBvcy50ZXN0Iiwicm9sZXMiOlsic3VwZXJhZG1pbiJdfQ.et_x4emJSlZRM9-D7FlNtU3gGxKuPHrZNl0oLDaiKe8';

  Map<String, String> _getHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_apiToken',
    };
  }

  Future<List<Product>> fetchProducts(String outletId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/outlets/$outletId/products'),
      headers: _getHeaders(),
    );

    print('Fetch Products Response Status: ${response.statusCode}');
    print('Fetch Products Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      final productsJson = jsonBody['products'] as List<dynamic>;
      return productsJson.map((p) => Product.fromJson(p)).toList();
    } else {
      throw Exception('Failed to load products: ${response.statusCode} - ${response.body}');
    }
  }

  Future<void> createProduct(Product product) async {
    final String url = '$baseUrl/outlets/${product.outlet_id}/products';
    print('Attempting to create product: ${product.name} at $url');
    try {
      final Map<String, dynamic> productData = {
        'name': product.name,
        'selling_price': product.selling_price,
        'category_id': product.category_id,
        'outlet_id': product.outlet_id,
        'stock': product.stock,
        'is_non_stock': product.is_non_stock,
        'initial_price': product.initial_price,
        'unit': product.unit,
        'hero_images': product.hero_images,
      };

      print('Sending JSON payload for create: ${jsonEncode(productData)}');

      final response = await http.post(
        Uri.parse(url),
        headers: _getHeaders(),
        body: jsonEncode(productData),
      );

      print('Create Product Response Status: ${response.statusCode}');
      print('Create Product Response Body: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Product created successfully!');
      } else {
        throw Exception("Failed to create product: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print('Error during createProduct: $e');
      throw Exception("Failed to create product: $e");
    }
  }

  Future<void> updateProduct(String id, Product product) async {
    final String url = '$baseUrl/products/$id';
    print('Attempting to update product $id: ${product.name} at $url');
    try {
      final Map<String, dynamic> productData = {
        'name': product.name,
        'selling_price': product.selling_price,
        'category_id': product.category_id,
        'outlet_id': product.outlet_id,
        'stock': product.stock,
        'is_non_stock': product.is_non_stock,
        'initial_price': product.initial_price,
        'unit': product.unit,
        'hero_images': product.hero_images,
      };

      print('Sending JSON payload for update: ${jsonEncode(productData)}');

      final response = await http.put(
        Uri.parse(url),
        headers: _getHeaders(),
        body: jsonEncode(productData),
      );

      print('Update Product Response Status: ${response.statusCode}');
      print('Update Product Response Body: ${response.body}');

      if (response.statusCode == 200) {
        print('Product updated successfully!');
      } else {
        throw Exception("Failed to update product: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print('Error during updateProduct: $e');
      throw Exception("Failed to update product: $e");
    }
  }

  Future<void> deleteProduct(String id) async {
    final String url = '$baseUrl/products/$id';
    print('Attempting to delete product: $id at $url');
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: _getHeaders(),
      );
      print('Delete Product Response Status: ${response.statusCode}');
      print('Delete Product Response Body: ${response.body}');

      if (response.statusCode == 200) {
        print('Product deleted successfully!');
      } else {
        throw Exception("Failed to delete product: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print('Error during deleteProduct: $e');
      throw Exception("Failed to delete product: $e");
    }
  }
}
