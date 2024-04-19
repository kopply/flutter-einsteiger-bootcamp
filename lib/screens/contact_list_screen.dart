import 'package:contact_app/widgets/avatar_with_initials.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/contact_manager.dart';
import 'contact_form_screen.dart';

class ContactListScreen extends StatelessWidget {
  const ContactListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Greift auf den ContactManager aus dem Provider zu, um Zugang zu den Kontaktdaten zu erhalten.
    final contactManager = Provider.of<ContactManager>(context);

    return Scaffold(
      backgroundColor:
          Colors.blueGrey.shade50, // Setzt die Hintergrundfarbe der Ansicht.
      appBar: AppBar(
        title: const Text('Kontaktliste'), // Titel der App-Leiste.
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons
                .add), // Fügt ein Icon-Button zum Hinzufügen neuer Kontakte hinzu.
            onPressed: () {
              // Navigiert zur Kontaktformular-Seite, um einen neuen Kontakt hinzuzufügen.
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactFormScreen()),
              ).then((_) => contactManager
                  .loadContacts()); // Lädt Kontakte neu, nachdem zur Liste zurückgekehrt wird.
            },
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ListView.builder(
            itemCount: contactManager
                .contacts.length, // Anzahl der Kontakte in der Liste.
            itemBuilder: (context, index) {
              final contact = contactManager.contacts[
                  index]; // Holt den Kontakt an der aktuellen Position.
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal:
                        8.0), // Fügt Padding um jeden Listeneintrag hinzu.
                child: Card(
                  color: Colors.white,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8.0),
                    leading: AvatarWithInitials(
                        firstName: contact.firstName ?? '',
                        lastName: contact.lastName ??
                            ''), // Fügt ein Telefon-Icon vor den Kontaktinformationen ein.
                    title: Text(contact
                        .getFullName()), // Zeigt den vollen Namen des Kontakts an.
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
