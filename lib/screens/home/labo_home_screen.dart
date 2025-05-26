import 'package:flutter/material.dart';
import 'package:pharmacoty/widget/custom.drawer.widget.labo.dart';

class LaboHomeScreen extends StatelessWidget {
  const LaboHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Accueil Laboratoire",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      drawer: const CustomDrawerLabo(), // Drawer spécifique labo
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.science, size: 100, color: Colors.green),
              SizedBox(height: 20),
              Text(
                "Bienvenue dans l'espace Laboratoire",
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
