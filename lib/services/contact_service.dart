import 'package:contact_app/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/contact.dart';

/**
 * Anmerkung:
 * Dies ist ein Trainingsbeispiel. In einer Produktionsumgebung oder in fortgeschrittenen
 * Kursen würden zusätzliche Themen behandelt, darunter:
 *
 * - Logging statt Print: Ersetzen von print()-Anweisungen durch eine professionelle
 *   Logging-Bibliothek, um eine bessere Kontrolle und Dokumentation der Laufzeitvorgänge zu ermöglichen.
 *
 * - Singleton-Muster: Implementierung des ContactService als Singleton, um eine einheitliche
 *   und zentrale Verwaltung von Zuständen und Ressourcen sicherzustellen.
 *
 * - Fehlerbehandlung: Erweiterte Fehlerbehandlungsstrategien, einschließlich der Verwendung von
 *   Fehlerbehandlungsmechanismen, die besser auf die spezifischen Bedürfnisse und das Fehlermodell
 *   der Anwendung abgestimmt sind.
 *
 * - Dependency Injection: Einführung von Dependency Injection zur besseren Verwaltung von Abhängigkeiten
 *   und zur Erhöhung der Testbarkeit und Modularität des Codes.
 */
class ContactService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();

  Future<List<Contact>> getContacts() async {
    try {
      String? userId = _authService.getUserId();
      if (userId == null) throw Exception('User not logged in');
      QuerySnapshot snapshot = await _firestore
          .collection('contacts')
          .doc(userId)
          .collection('userContacts')
          .get();
      return snapshot.docs
          .map((doc) => Contact.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error, kann keine Kontakte laden: $e');
      return [];
    }
  }

  Future<void> addContact(Contact contact) async {
    String? userId = _authService.getUserId();
    if (userId == null) throw Exception('User not logged in');
    try {
      await _firestore
          .collection('contacts')
          .doc(userId)
          .collection('userContacts')
          .add(contact.toMap());
    } catch (e) {
      print('Error, kann keinen neuen Kontakt anlegen: $e');
      rethrow;
    }
  }
}
