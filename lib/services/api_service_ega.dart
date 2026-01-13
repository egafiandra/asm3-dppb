import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';

class ApiServiceEga {
  // Helper: Ambil Token dari penyimpanan lokal
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Helper: Header HTTP standar dengan Token
  Future<Map<String, String>> getHeaders() async {
    final token = await getToken();
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // Method untuk mendapatkan menu (untuk home_screen)
  Future<List<dynamic>> getMenu() async {
    try {
      final headers = await getHeaders();
      final response = await http.get(
        Uri.parse('${AppConstants.baseUrl}/menu'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json is Map && json.containsKey('data')) {
          return json['data'];
        } else if (json is List) {
          return json;
        }
      }
    } catch (e) {
      print("Get Menu Error: $e");
    }
    return [];
  }

  // Method untuk membuat reservasi (untuk reservation_form_screen)
  Future<bool> createReservation(Map<String, dynamic> reservationData) async {
    try {
      final headers = await getHeaders();
      final response = await http.post(
        Uri.parse('${AppConstants.baseUrl}/reservations'),
        headers: headers,
        body: jsonEncode(reservationData),
      );
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print("Create Reservation Error: $e");
      return false;
    }
  }

  // Method untuk mendapatkan reservasi pengguna (untuk my_reservation_screen)
  Future<List<dynamic>> getReservations() async {
    try {
      final headers = await getHeaders();
      final response = await http.get(
        Uri.parse('${AppConstants.baseUrl}/reservations'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json is Map && json.containsKey('data')) {
          return json['data'];
        } else if (json is List) {
          return json;
        }
      }
    } catch (e) {
      print("Get Reservations Error: $e");
    }
    return [];
  }

  // Method untuk mendapatkan status order (untuk order_status_screen)
  Future<List<dynamic>> getOrders() async {
    try {
      final headers = await getHeaders();
      final response = await http.get(
        Uri.parse('${AppConstants.baseUrl}/orders'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json is Map && json.containsKey('data')) {
          return json['data'];
        } else if (json is List) {
          return json;
        }
      }
    } catch (e) {
      print("Get Orders Error: $e");
    }
    return [];
  }
}