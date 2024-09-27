import 'package:flutter/material.dart';
import 'package:mobil_cinephoria/models/reservation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../services/api_service.dart';
import 'QRCodeScreen.dart';

class ReservationScreen extends StatefulWidget {
final String utilisateurId;

  ReservationScreen({required this.utilisateurId});

  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  late Future<List<Reservation>> _reservationsFuture;


  @override
  void initState() {
    super.initState();
    _reservationsFuture = _loadReservations();
  }


  Future<List<Reservation>> _loadReservations() async {

  return ApiService().getReservations(widget.utilisateurId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Réservations')),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Reservation>>(
              future: _reservationsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erreur: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Aucune réservation trouvée'));
                } else {
                  final reservations = snapshot.data!;
                  return ListView.builder(
                    itemCount: reservations.length,
                    itemBuilder: (context, index) {
                      final reservation = reservations[index];
                      String imageUrl = 'http://13.38.118.50/uploads/images/${reservation.idImage}';
                      print(imageUrl);
                      return ListTile(
                        leading: Image.network(
                          imageUrl, 
                          
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.image_not_supported); // Si l'image ne se charge pas
                          },
                        ),
                        title: Text(reservation.film),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Date: ${reservation.jour}'),
                            Text('Heure: ${reservation.debut} - ${reservation.fin}'),
                            Text('Salle: ${reservation.salle}'),
                            Text('Places réservées: ${reservation.nbPlacesReserve}'),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.qr_code),
                          onPressed: () {
                            // Navigation vers la page QRCodeScreen avec l'ID de la réservation
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QrCodeScreen(
                                  reservationId: reservation.idReservation.toString(),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
