import 'package:flutter/material.dart';

class AvatarWithInitials extends StatelessWidget {
  final String firstName;
  final String lastName;
  final double size;

  const AvatarWithInitials(
      {super.key,
      required this.firstName,
      required this.lastName,
      this.size = 25.0});

  @override
  Widget build(BuildContext context) {
    String initials = getInitials(firstName, lastName);
    return CircleAvatar(
      backgroundColor: Colors.blueGrey,
      radius: size,
      child: Text(
        initials,
        style: const TextStyle(
          fontSize: 22,
          color: Colors.white,
        ),
      ),
    );
  }

  String getInitials(String firstName, String lastName) {
    String initials = "";
    initials += firstName[0]; // Erstes Zeichen des ersten Namens
    initials += lastName[0]; // Erstes Zeichen des Nachnamens

    return initials.toUpperCase();
  }
}
