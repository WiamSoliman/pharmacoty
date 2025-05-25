import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharmacoty/widget/drawer.header.dart';
import 'package:pharmacoty/widget/drawer.item.dart';

class CustomDrawerPatient extends StatelessWidget {
  const CustomDrawerPatient({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const CustomDrawerHeader(),

          DrawerItem(
            title: "Accueil",
            itemIcon: const Icon(Icons.home),
            route: "/home",
          ),
          const Divider(height: 9, color: Colors.green),
          DrawerItem(
            title: "Scanner QR",
            itemIcon: const Icon(Icons.qr_code),
            route: "/scan",
          ),
          const Divider(height: 9, color: Colors.green),
          DrawerItem(
            title: "Historique",
            itemIcon: const Icon(Icons.history),
            route: "/patient-hist",
          ),
          const Divider(height: 20, color: Colors.green),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              "Déconnexion",
              style: TextStyle(color: Colors.red),
            ),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Déconnexion réussie'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
