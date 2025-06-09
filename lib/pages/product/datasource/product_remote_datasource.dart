import 'package:ecopos/pages/product/models/product_response_model.dart';
import 'package:ecopos/util/auth_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductRemoteDatasource {
  Future<Map<String, dynamic>> createProduct(
      ProductElement product, http.MultipartFile hero_image) async {
    final String baseUrl = "https://tannn.my.id/api";
    final token = AuthManager.readAuth();
    final outlet_id = AuthManager.getOutlet();
    if (outlet_id == null) {
      return {
        'success': false,
        'message':
            'Outlet belum dipilih atau tidak ditemukan. Harap login ulang.'
      };
    }

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/outlets/$outlet_id/products'),
    );

    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    request.fields.addAll({
      'name': product.name ?? '',
      'category_id': product.categoryId ?? '',
      'stock': product.stock?.toString() ?? '0',
      'is_non_stock': (product.isNonStock ?? false).toString(),
      'initial_price': product.initialPrice ?? '0',
      'selling_price': product.sellingPrice ?? '0',
      'unit': product.unit ?? '',
      // tambahkan field lain kalau perlu
    });

    request.files.add(hero_image);

    print('🧾 Kirim Data (Update): ${request.fields}');
    print('🖼 Gambar: ${hero_image?.filename}');
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    print('📥 Status (Update): ${response.statusCode}');
    print('📦 Body (Update): ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return {'success': true, 'data': data};
    } else {
      final data = jsonDecode(response.body);
      final errorMessage = data['message'] ?? 'Gagal menambahkan produk';
      return {'success': false, 'message': errorMessage};
    }
  }

  Future<Map<String, dynamic>> getProduct() async {
    try {
      final String baseUrl = "https://tannn.my.id/api";
      final token = AuthManager.readAuth();
      final outlet_id = AuthManager.getOutlet();
      print('🔐 Token: $token');
      print('🆔 Outlet ID: ${AuthManager.getOutlet()}');

      final response = await http.get(
        Uri.parse('$baseUrl/outlets/$outlet_id/products'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      print('📥 Status Code: ${response.statusCode}');
      print('📦 Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {'success': true, 'data': data};
      } else {
        return {'success': false, 'message': 'Gagal mengambil data produk'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Terjadi kesalahan'};
    }
  }

  Future<Map<String, dynamic>> updateProduct({
    required String product_id,
    required String name,
    required String selling_price,
    required String category_id,
    required int stock,
    required bool is_non_stock,
    required String initial_price,
    required String unit,
    http.MultipartFile? hero_image, // file hero_images (optional)
  }) async {
    try {
      final String baseUrl = "https://tannn.my.id/api";
      final token = AuthManager.readAuth();
      final outlet_id = AuthManager.getOutlet();

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/outlets/$outlet_id/products/$product_id'),
      );

      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      request.fields.addAll({
        'name': name,
        'selling_price': selling_price,
        'category_id': category_id,
        'stock': stock.toString(),
        'is_non_stock': is_non_stock ? 'true' : 'false',
        'initial_price': initial_price,
        'unit': unit,
      });

      if (hero_image != null) {
        request.files.add(hero_image);
      }

      print('🧾 Kirim Data (Update): ${request.fields}');
      print('🖼 Gambar: ${hero_image?.filename}');

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print('📥 Status (Update): ${response.statusCode}');
      print('📦 Body (Update): ${response.body}');

      final json = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {'success': true, 'data': json['data'], 'token': token};
      } else {
        final errorMessage = json['message'] ?? 'Gagal Update Produk';
        return {'success': false, 'message': errorMessage};
      }
    } catch (e) {
      return {'success': false, 'message': 'Terjadi kesalahan server.'};
    }
  }

  Future<Map<String, dynamic>> deleteProduct(String productId) async {
    try {
      final String baseUrl = "https://tannn.my.id/api";
      final token = AuthManager.readAuth();
      final outlet_id = AuthManager.getOutlet();

      final response = await http.delete(
        Uri.parse('$baseUrl/outlets/$outlet_id/products/$productId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      print('📥 Status Code: ${response.statusCode}');
      print('📦 Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 204) {
        // API standar kadang mengembalikan 204 No Content
        return {'success': true};
      } else {
        final data = jsonDecode(response.body);
        final errorMessage = data['message'] ?? 'Gagal menghapus produk';
        return {'success': false, 'message': errorMessage};
      }
    } catch (e) {
      return {'success': false, 'message': 'Terjadi kesalahan server'};
    }
  }
}
