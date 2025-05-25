import 'package:flutter/material.dart';
import 'labo_home_screen.dart';
import 'pharma_home_screen.dart';
import 'patient_home_screen.dart';

class HomeScreen extends StatelessWidget {
  final String role;
  const HomeScreen({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    if (role == 'laboratoire') {
      return const LaboHomeScreen();
    } else if (role == 'pharmacie') {
      return const PharmaHomeScreen();
    } else if (role == 'patient') {
      return const PatientHomeScreen();
    } else {
      return const Scaffold(body: Center(child: Text('Rôle inconnu')));
    }
  }
}
