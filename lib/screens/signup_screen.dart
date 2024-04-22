import 'package:contact_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _authService = AuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  // Optional: Validierung für korrete Email
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Bitte gib eine valide Emailadresse ein';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  // Optional: Validierung eines Passworts
                  if (value!.isEmpty || value.length < 6) {
                    return 'Password muss mindestens 6 Zeichen haben';
                  }
                  return null;
                },
              ),
            ),
            ElevatedButton(
              onPressed: () => _register(context),
              child: const Text('Registrieren'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Schon registriert? Melde dich an"),
            ),
          ],
        ),
      ),
    );
  }

  void _register(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // Überprüft die Eingaben des Nutzers
      try {
        final user = await _authService.createUserWithEmailAndPassword(
          _emailController.text,
          _passwordController.text,
        );
        if (user != null) {
          Navigator.of(context).pop();
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Fehler bei der Registrierung: ${e.toString()}')),
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
