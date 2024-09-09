class Reservation {
  final int idReservation;
  final String film;
  final String idImage;
  final String jour;
  final String salle;
  final String debut;
  final String fin;
  final int nbPlacesReserve;

  Reservation({
    required this.idReservation,
    required this.film,
    required this.idImage,
    required this.jour,
    required this.salle,
    required this.debut,
    required this.fin,
    required this.nbPlacesReserve,
  });

    factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      idReservation: json['idReservation'] ?? 0,
      film: json['film'] ?? '',
      idImage: json['idImage'] ?? '',  
      jour: json['jour'] ?? '',
      salle: json['salle'] ?? '',
      debut: json['debut'] ?? '',
      fin: json['fin'] ?? '',
      nbPlacesReserve: json['nbPlacesReserve'] ?? 0,
    );
  }

}
