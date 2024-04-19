import 'package:contact_app/screens/contact_form_screen.dart';
import 'package:contact_app/services/contact_service.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  ContactService contactService = ContactService();
  await contactService.init();

  runApp(MaterialApp(
    home: ContactFormScreen(contactService: contactService),
  ));
}
