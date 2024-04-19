import 'package:contact_app/screens/contact_list_screen.dart';
import 'package:contact_app/services/contact_manager.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'models/contact.dart';

void main() async {
  // Stelle sicher, dass Widgets gebunden sind, bevor Sie Flutter-Funktionen verwenden.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisiert Hive für Flutter, eine lokale NoSQL-Datenbank.
  await Hive.initFlutter();

  // Registriert den Hive Adapter für Contact-Objekte, um deren Speicherung zu ermöglichen.
  Hive.registerAdapter(ContactAdapter());

  // Startet die Flutter-App und stellt den ContactManager bereit, der über ChangeNotifierProvider verwaltet wird.
  runApp(
    ChangeNotifierProvider(
      // Erstellt eine Instanz von ContactManager und öffnet die Hive-Box.
      create: (_) => ContactManager()..openBox(),
      // MaterialApp ist das Wurzel-Widget der App, setzt ContactListScreen als Startbildschirm.
      child: MaterialApp(
        home: ContactListScreen(),
      ),
    ),
  );
}
