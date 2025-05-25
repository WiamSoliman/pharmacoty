import 'package:flutter/material.dart';
import 'package:pharmacoty/widget/custom.drawer.widget.pharma.dart';

class PharmaHomeScreen extends StatelessWidget {
  const PharmaHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Accueil Pharmacie",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      drawer: const CustomDrawerPharma(), // Drawer spécifique pharmacie
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.local_pharmacy, size: 100, color: Colors.green),
              SizedBox(height: 20),
              Text(
                "Bienvenue dans l'espace Pharmacie",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
