import 'package:contact_app/services/contact_service.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/contact.dart';

class ContactManager with ChangeNotifier {
  late Box<Contact> contactBox; // Die Hive-Box für Kontakte.
  final ContactService _contactService = ContactService();

  List<Contact> _contacts = []; // Interne Liste von Kontakten.

  // Stellt eine unveränderliche Liste von Kontakten zur Verfügung, um externe Modifikationen zu verhindern.
  List<Contact> get contacts => List.unmodifiable(_contacts);

// Initialize the manager by opening the box and synchronizing contacts
  Future<void> init() async {
    await openBox();
    await loadContacts();
  }

  // Öffnet die Hive-Box und lädt die Kontakte beim Start.
  Future<void> openBox() async {
    contactBox = await Hive.openBox<Contact>('contacts');
    await loadContacts();
  }

  // Lädt Kontakte aus der Hive-Box und benachrichtigt Listener über Änderungen.
  Future<void> loadContacts() async {
    _contacts = await _contactService
        .getContacts(); // Aktualisiert die lokale Kontaktliste
    notifyListeners(); // Benachrichtigt alle Widgets, die zuhören, über die Aktualisierung
  }

  // Fügt einen neuen Kontakt zur Hive-Box hinzu und aktualisiert die Kontaktliste.
  Future<void> addContact(Contact contact) async {
    await _contactService
        .addContact(contact); // Fügt den Kontakt zur Hive-Box hinzu
    await loadContacts(); // Erneuert die Kontaktliste nach dem Hinzufügen
  }

  // Optional: Gibt Ressourcen frei, wenn der Manager nicht mehr benötigt wird.
  @override
  void dispose() {
    contactBox.close(); // Schließt die Hive-Box, wenn der Manager zerstört wird
    super.dispose();
  }
}
