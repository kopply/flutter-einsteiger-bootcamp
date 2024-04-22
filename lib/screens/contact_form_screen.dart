import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/contact.dart';
import '../services/contact_manager.dart';

/**
 * Anmerkungen zur Übungs-App:
 *
 * - Effiziente Snackbar-Nachrichten:
 *   Obwohl die Implementierung der Snackbar gut ist, ist es wichtig sicherzustellen,
 *   dass diese Benachrichtigungen immer sichtbar sind und nicht von anderen UI-Elementen,
 *   wie der aufklappenden Tastatur, verdeckt werden. Dies verbessert die Benutzererfahrung,
 *   indem sichergestellt wird, dass Feedback sichtbar und informativ ist.
 *
 * - Vermeidung von direktem 'print':
 *   Die Verwendung von 'print(contactService.getContacts());' ist hilfreich für Debugging-Zwecke.
 *   In einem Produktionsumfeld sollten jedoch professionelle Logging-Tools verwendet werden,
 *   die mehr Kontrolle und Flexibilität bieten, um den Überblick über die Anwendungslogik zu bewahren.
 *
 * - Verbesserung der Formularvalidierung:
 *   Die derzeitige Implementierung der Validierungslogik direkt im TextFormField ist praktisch für einfache Fälle.
 *   Für eine komplexere Validierungslogik ist es empfehlenswert, diese in separate Methoden auszulagern.
 *   Dies macht die 'build'-Methode sauberer und die gesamte Anwendung wartbarer.
 *
 * - Asynchrone Fehlerbehandlung:
 *   Die Fehlerbehandlung in der '_saveContact'-Methode könnte verbessert werden, um die Robustheit der App zu erhöhen.
 *   Die Nutzung von Try-Catch-Blöcken zur Erfassung und Behandlung von Laufzeitfehlern ist ratsam, um sicherzustellen,
 *   dass die App auch bei unerwarteten Fehlern stabil bleibt und angemessenes Feedback gibt.
 *
 * Diese Hinweise sind besonders wichtig für die Entwicklung einer stabilen und benutzerfreundlichen Anwendung.
 * Sie stellen sicher, dass die App auch unter verschiedenen Bedingungen und Einsatzszenarien zuverlässig funktioniert.
 */

class ContactFormScreen extends StatefulWidget {
  final Contact initialContact =
      new Contact(); // Initialer leerer Kontakt, der als Vorlage dient.

  ContactFormScreen({super.key});

  @override
  _ContactFormScreenState createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends State<ContactFormScreen> {
  final _formKey = GlobalKey<
      FormState>(); // Globales Schlüsselobjekt für das Formular zur Validierung.

  late TextEditingController _firstNameController =
      TextEditingController(text: widget.initialContact.firstName);
  late TextEditingController _lastNameController =
      TextEditingController(text: widget.initialContact.lastName);
  late TextEditingController _phoneController =
      TextEditingController(text: widget.initialContact.phoneNumber);

  @override
  void initState() {
    super.initState();
    // Initialisiere die Textfeld-Controller mit den initialen Werten des Kontakts oder leeren Strings.
    _firstNameController =
        TextEditingController(text: widget.initialContact.firstName ?? '');
    _lastNameController =
        TextEditingController(text: widget.initialContact.lastName ?? '');
    _phoneController =
        TextEditingController(text: widget.initialContact.phoneNumber ?? '');
  }

  @override
  void dispose() {
    // Bereinige die Controller, um Speicherlecks zu vermeiden.
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveContact() async {
    // Druckt den aktuellen Kontakt zur Debugging-Zwecke.
    print('save contact in form: ${widget.initialContact}');
    if (_formKey.currentState!.validate()) {
      final newContact = Contact(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        phoneNumber: _phoneController.text,
      );

      // Zugriff auf den ContactManager aus dem Provider.
      final contactManager =
          Provider.of<ContactManager>(context, listen: false);

      try {
        await contactManager.addContact(newContact);

        // Bereinige die Eingabefelder nach erfolgreichem Speichern.
        _firstNameController.clear();
        _lastNameController.clear();
        _phoneController.clear();
        FocusScope.of(context).unfocus();

        // Verlasse die aktuelle Seite und zeige eine Snackbar zur Bestätigung.
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Kontakt gespeichert'),
            duration: Duration(seconds: 2),
          ),
        );
      } catch (e) {
        // Zeige eine Fehlermeldung, wenn das Speichern fehlschlägt.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Fehler beim Speichern des Kontakts'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kontakt erstellen'), // Titel der Seite
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'Vorname'),
                validator: (value) {
                  // Validiere den Vornamen auf Nicht-Leerheit.
                  if (value == null || value.isEmpty) {
                    return 'Bitte gib einen Vornamen ein';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Nachname'),
                validator: (value) {
                  // Validiere den Nachnamen auf Nicht-Leerheit.
                  if (value == null || value.isEmpty) {
                    return 'Bitte gib einen Nachnamen ein';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Telefonnummer'),
                validator: (value) {
                  // Validiere die Telefonnummer auf Nicht-Leerheit.
                  if (value == null || value.isEmpty) {
                    return 'Bitte gib eine Telefonnummer ein';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed:
                    _saveContact, // Ruft die Methode zum Speichern des Kontakts auf.
                child: Text('Kontakt speichern'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
