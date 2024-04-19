import 'package:hive/hive.dart';

/**
 * Anmerkung:
 *
 * Das ist ein Trainingsbeispiel. Für Produktion würde man noch das folgende umsetzen:
 * - Fehlerbehandlung: Zusätzliche Validierungen oder Fehlerbehandlungen, um die Robustheit des Codes zu erhöhen.
 * - Nullable Felder: Felder sind nullable (String?), daher sollte man überlegen, bestimmte Überprüfungen einzuführen, um sicherzustellen, dass keine ungültigen oder unerwarteten null-Werte verarbeitet werden.
 * */

part 'contact.g.dart'; // Diese Datei wird automatisch von Hive generiert.

@HiveType(
    typeId:
        1) // Stelle sicher, dass die typeId einzigartig ist, wenn du weitere HiveTypes verwendest.
class Contact {
  @HiveField(0)
  final String? firstName; // Das Vorname-Feld, indiziert mit 0 für Hive.
  @HiveField(1)
  final String? lastName; // Das Nachname-Feld, indiziert mit 1 für Hive.
  @HiveField(2)
  final String?
      phoneNumber; // Das Telefonnummer-Feld, indiziert mit 2 für Hive.

  // Konstruktor zur Initialisierung eines Kontakts.
  Contact({
    this.firstName,
    this.lastName,
    this.phoneNumber,
  });

  // Methode, um einen Kontakt in eine Map umzuwandeln, nützlich für Datenbanken oder das Senden über Netzwerke.
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
    };
  }

  // Factory-Konstruktor, um eine neue Instanz von Contact aus einer Map zu erstellen,
  // nützlich beim Abrufen von Daten aus einer Datenbank oder API.
  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      firstName: map['firstName'],
      lastName: map['lastName'],
      phoneNumber: map['phoneNumber'],
    );
  }

  // Überschreibt die toString-Methode, um eine lesbare Darstellung eines Kontaktobjekts zu bieten.
  @override
  String toString() {
    return 'Contact(firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber)';
  }
}
