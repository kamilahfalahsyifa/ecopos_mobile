import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ecopos/gitit/gitit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static final ValueNotifier<String?> authChangeNotifire = ValueNotifier(null);
  static final SharedPreferences _sharedPref = locator.get();

  static void saveToken(String token) async {
    _sharedPref.setString('access_token', token);
    authChangeNotifire.value = token;
    debugPrint('🔐 Token disimpan: $token');
  }

  static void saveId(String id) async {
    _sharedPref.setString('user_id', id);
    debugPrint('👤 User ID disimpan: $id');
  }

  static void saveOutlet(String? id) async {
    if (id != null && id.toLowerCase() != 'null' && id.trim().isNotEmpty) {
      _sharedPref.setString('outlet_id', id);
      debugPrint('🏪 Outlet ID disimpan: $id');
    } else {
      debugPrint('⚠️ Gagal menyimpan outlet ID: ID tidak valid');
    }
  }

  static void saveProduct(String id) async {
    _sharedPref.setString('product_id', id);
  }

  static String getId() {
    return _sharedPref.getString('user_id') ?? '';
  }

  static String? getOutlet() {
    final outlet = _sharedPref.getString('outlet_id');
    if (outlet == null || outlet.toLowerCase() == 'null' || outlet.trim().isEmpty) {
      debugPrint('❌ Outlet ID tidak ditemukan atau tidak valid');
      return null;
    }
    debugPrint('📥 Outlet ID diambil: $outlet');
    return outlet;
  }

  static String getProduct() {
    return _sharedPref.getString('product_id') ?? '';
  }

  static String readAuth() {
    return _sharedPref.getString('access_token') ?? '';
  }

  static void logout() {
    _sharedPref.clear();
    authChangeNotifire.value = null;
    debugPrint('🚪 Logout: semua data telah dihapus');
  }

  static bool isLogedin() {
    String token = readAuth();
    return token.isNotEmpty;
  }
}
