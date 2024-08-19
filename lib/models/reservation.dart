class Reservation {
  final int idReservation;
  final String film;
  final String affiche;
  final String jour;
  final String salle;
  final String debut;
  final String fin;
  final int nbPlacesReserve;

  Reservation({
    required this.idReservation,
    required this.film,
    required this.affiche,
    required this.jour,
    required this.salle,
    required this.debut,
    required this.fin,
    required this.nbPlacesReserve,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      idReservation: json['idReservation'],
      film: json['film'],
      affiche: json['affiche'],
      jour: json['jour'],
      salle: json['salle'],
      debut: json['debut'],
      fin: json['fin'],
      nbPlacesReserve: json['nbPlacesReserve'],
    );
  }
}
