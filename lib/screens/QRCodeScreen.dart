import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../services/api_service.dart'; // Importez votre service API

class QrCodeScreen extends StatelessWidget {
  final String reservationId;

  QrCodeScreen({required this.reservationId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code'),
      ),
      body: FutureBuilder <String>(
        future: ApiService().getQrCode(reservationId), // Utilisez la méthode de votre ApiService
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
             print(snapshot.data);
            return Center(
              
              child: QrImageView(
                data: snapshot.data!, // Affichez les données JSON récupérées dans le QR code
                version: QrVersions.auto,
                size: 300.0,
              ),
            );
          } else {
            return Center(child: Text('No data found'));
          }
        },
      ),
    );
  }
}
