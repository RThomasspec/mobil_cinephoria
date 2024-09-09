import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/reservation.dart';
class ApiService {
  final String baseUrl = 'http://13.38.118.50/api';

  ApiService();

Future<List<Reservation>> getReservations(String utilisateurId) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/reservations'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'utilisateur_id': utilisateurId}),
    );
  // ignore: prefer_interpolation_to_compose_strings

    if (response.statusCode == 200) {
      print('Response body: ${response.body}');  // Affiche le corps de la réponse pour déboguer

      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      // Assurez-vous que la clé "reservations" existe et est une liste
      if (jsonResponse['reservationDetails'] is List) {
        final List<dynamic> reservationsJson = jsonResponse['reservationDetails'];

        return reservationsJson.map((data) {
          print('Data item: $data');  // Affiche chaque élément de données pour déboguer
          return Reservation.fromJson(data);
        }).toList();
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('Failed to load reservations: ${response.reasonPhrase}');
    }
  } catch (e) {
    print('Exception: $e');  // Affiche l'exception pour déboguer
    throw Exception('Failed to load reservations: $e');
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

      // Vérifie que la liste 'reservation_details' n'est pas vide
      if (jsonResponse['reservation_details'] != null && jsonResponse['reservation_details'].isNotEmpty) {
        final firstReservation = jsonResponse['reservation_details'][0];

        // Construit une chaîne de caractères avec les informations du JSON
        String qrCodeData = 'Film: ${firstReservation['film']}, '
            'Jour: ${firstReservation['jour']}, '
            'Salle: ${firstReservation['salle']}, '
            'Début: ${firstReservation['debut']}, '
            'Fin: ${firstReservation['fin']}, '
            'Places réservées: ${firstReservation['nbPlacesReserve']}';

        return qrCodeData;
      } else {
        throw Exception('No reservation details found');
      }
    } else {
      throw Exception('Failed to generate QR code');
    }
  }
}


  

