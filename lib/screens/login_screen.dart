import 'package:contact_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    try {
      final user = await _authService.signInWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );
      if (user != null) {
        Navigator.of(context).pushReplacementNamed('/');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Container(
        margin: const EdgeInsets.all(18.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pushNamed('/signup'),
              child: Text("Neu hier? Registiere dich jetzt"),
            ),
          ],
        ),
      ),
    );
  }
}
