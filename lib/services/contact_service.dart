import 'package:hive/hive.dart';

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
  late Box<Contact> contactsBox;

  Future<void> init() async {
    Hive.registerAdapter(ContactAdapter());
    contactsBox = await Hive.openBox<Contact>('contacts');
  }

  List<Contact> getContacts() {
    try {
      return contactsBox.values.toList();
    } catch (e) {
      print('Error retrieving contacts: $e');
      return [];
    }
  }

  Future<void> addContact(Contact contact) async {
    try {
      await contactsBox.add(contact);
    } catch (e) {
      print('Error adding contact: $e');
      rethrow;
    }
  }
}
