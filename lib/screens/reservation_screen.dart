import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../services/api_service.dart';
import '../models/reservation.dart';
import '../widget/qr_code.dart'; // Créez ce widget pour afficher le QR code

class ReservationScreen extends StatefulWidget {
  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  late Future<List<Reservation>> reservations;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _loadReservations();
  }

 void _loadReservations() async {
  final storage = FlutterSecureStorage();
  final utilisateurId = await storage.read(key: 'utilisateur_id'); // On récupère l'utilisateur_id

  if (utilisateurId != null) {
    // Assurez-vous que utilisateurId est bien un entier et non null
    final reservationsData = await apiService.getReservations(int.parse(utilisateurId));

    // Mettez à jour l'état une fois les données récupérées
    setState(() {
      reservations = reservationsData;
    });
  } else {
    // Gérer le cas où l'utilisateur_id est null
    print("utilisateur_id is null");
  }
}


  Future<void> _generateQrCode(String reservationId) async {
    try {
      final qrCodeBase64 = await apiService.getQrCode(reservationId);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('QR Code'),
          content: QrCodeWidget(data: qrCodeBase64),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to generate QR code')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Reservations')),
      body: FutureBuilder<List<Reservation>>(
        future: reservations,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No reservations found'));
          }

          final reservations = snapshot.data!;

          return ListView.builder(
            itemCount: reservations.length,
            itemBuilder: (context, index) {
              final reservation = reservations[index];
              return ListTile(
                title: Text(reservation.film),
                subtitle: Text('Date: ${reservation.jour}\n Heure: ${reservation.debut} ${reservation.fin}'),
                trailing: IconButton(
                  icon: Icon(Icons.qr_code),
                  onPressed: () {
                    _generateQrCode(reservation.idReservation.toString());
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
