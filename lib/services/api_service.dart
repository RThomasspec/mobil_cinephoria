import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/reservation.dart';

class ApiService {
  final String baseUrl = 'http://13.38.118.50/api';

  Future<List<Reservation>> getReservations(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/reservations'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Reservation.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load reservations');
    }
  }

  Future<Map<String, dynamic>> apilogin(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      // Réponse réussie, retourner le corps de la réponse sous forme de Map
      return json.decode(response.body);
    } else {
      // Erreur dans la réponse
      throw Exception('Failed to login: ${response.body}');
    }
  }



  Future<String> getQrCode(String reservationId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/qr-code'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'reservation_id': reservationId}),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse['qr_code'];
    } else {
      throw Exception('Failed to generate QR code');
    }
  }
}
