import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return FutureBuilder<DocumentSnapshot>(
      future:
          FirebaseFirestore.instance
              .collection('utilisateurs')
              .doc(user?.uid)
              .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const DrawerHeader(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return const DrawerHeader(
            child: Center(child: Text('Erreur de chargement')),
          );
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const DrawerHeader(
            child: Center(child: Text('Utilisateur introuvable')),
          );
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;
        final nom = data['nom'] ?? 'Utilisateur';
        final photoUrl = data['photoUrl'];

        return DrawerHeader(
          decoration: BoxDecoration(color: Colors.green),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/mon-profil');
            },
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      (photoUrl != null && photoUrl.isNotEmpty)
                          ? NetworkImage(photoUrl)
                          : const AssetImage("assets/userpharmacoty.jpg")
                              as ImageProvider,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    nom,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
