import 'package:flutter/material.dart';

import '../models/contact.dart';
import '../services/contact_service.dart';

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
      new Contact(); // Vordefinierter leerer Kontakt.
  final ContactService contactService;

  ContactFormScreen({super.key, required this.contactService});

  @override
  _ContactFormScreenState createState() =>
      _ContactFormScreenState(contactService);
}

class _ContactFormScreenState extends State<ContactFormScreen> {
  final ContactService contactService;
  final _formKey =
      GlobalKey<FormState>(); // Key für das Formular zur Validierung.
  late TextEditingController _firstNameController =
      TextEditingController(text: widget.initialContact.firstName);
  late TextEditingController _lastNameController =
      TextEditingController(text: widget.initialContact.lastName);
  late TextEditingController _phoneController =
      TextEditingController(text: widget.initialContact.phoneNumber);

  // Constructor accepting the contactService from the widget
  _ContactFormScreenState(this.contactService);

  @override
  void initState() {
    super.initState();

    // Initialisierung der Controller mit leeren oder vordefinierten Werten.
    _firstNameController =
        TextEditingController(text: widget.initialContact.firstName ?? '');
    _lastNameController =
        TextEditingController(text: widget.initialContact.lastName ?? '');
    _phoneController =
        TextEditingController(text: widget.initialContact.phoneNumber ?? '');
  }

  @override
  void dispose() {
    // Controller müssen bereinigt werden, um Ressourcen freizugeben.
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveContact() async {
    if (_formKey.currentState!.validate()) {
      try {
        final newContact = Contact(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          phoneNumber: _phoneController.text,
        );

        await this.contactService.addContact(newContact);

        _firstNameController.clear();
        _lastNameController.clear();
        _phoneController.clear();
        FocusScope.of(context).unfocus();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Kontakt gespeichert'),
              duration: Duration(seconds: 2)),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Fehler beim Speichern des Kontakts'),
              duration: Duration(seconds: 2)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kontakt erstellen'),
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
                  // Validierung des Vornamens.
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
                  // Validierung des Nachnamens.
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
                  // Validierung der Telefonnummer.
                  if (value == null || value.isEmpty) {
                    return 'Bitte gib eine Telefonnummer ein';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveContact,
                child: Text('Save Contact'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
