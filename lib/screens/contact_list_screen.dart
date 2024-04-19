import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/contact_manager.dart';
import 'contact_detail_screen.dart';
import 'contact_form_screen.dart';

class ContactListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Greift auf den ContactManager aus dem Provider zu, um Zugang zu den Kontaktdaten zu erhalten.
    final contactManager = Provider.of<ContactManager>(context);

    return Scaffold(
      backgroundColor:
          Colors.blueGrey.shade50, // Setzt die Hintergrundfarbe der Ansicht.
      appBar: AppBar(
        title: Text('Kontaktliste'), // Titel der App-Leiste.
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons
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
        child: ListView.builder(
          itemCount: contactManager
              .contacts.length, // Anzahl der Kontakte in der Liste.
          itemBuilder: (context, index) {
            final contact = contactManager
                .contacts[index]; // Holt den Kontakt an der aktuellen Position.
            return Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 2,
                  horizontal: 4), // Fügt Padding um jeden Listeneintrag hinzu.
              child: ListTile(
                tileColor: Colors
                    .white, // Setzt die Hintergrundfarbe des Listeneintrags.
                leading: Icon(Icons
                    .phone), // Fügt ein Telefon-Icon vor den Kontaktinformationen ein.
                title: Text(contact
                    .getFullName()), // Zeigt den vollen Namen des Kontakts an.
                onTap: () {
                  // Navigiere zum ContactDetailScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ContactDetailScreen(contact: contact),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
