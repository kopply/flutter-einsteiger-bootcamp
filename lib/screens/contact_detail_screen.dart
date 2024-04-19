import 'package:contact_app/widgets/avatar_with_initials.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/contact.dart';

class ContactDetailScreen extends StatelessWidget {
  final Contact contact;

  // Konstruktor, der den Kontakt als erforderliches Argument nimmt.
  const ContactDetailScreen({Key? key, required this.contact})
      : super(key: key);

  // Methode zum Initiieren eines Telefonanrufs.
  void _makePhoneCall(BuildContext context) async {
    var uri = Uri.parse(
        'tel:${contact.phoneNumber}'); // Erstellt die URI aus der Telefonnummer.
    try {
      await canLaunchUrl(uri);
      await launchUrl(uri); // Startet den Anruf, wenn möglich.
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // Methode zum Kopieren der Telefonnummer in die Zwischenablage.
  void _copyToClipboard(BuildContext context) {
    if (contact.phoneNumber != null) {
      Clipboard.setData(ClipboardData(text: contact.phoneNumber!));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nummer kopiert: ${contact.phoneNumber}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Keine Telefonnummer verfügbar')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        title: const Text('Kontaktdetails'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 25.0),
              child: AvatarWithInitials(
                  firstName: contact.firstName ?? '',
                  lastName: contact.lastName ?? '',
                  size: 60.0),
            ),
            Text('${contact.firstName} ${contact.lastName}',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            Card(
              color: Colors.white,
              child: ListTile(
                leading: const Icon(Icons.phone),
                title: Text('${contact.phoneNumber}'),
                onTap: () => _makePhoneCall(context),
                onLongPress: () => _copyToClipboard(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
