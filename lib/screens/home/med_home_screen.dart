import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharmacoty/widget/custom.drawer.widget.med.dart';

class MedHomeScreen extends StatefulWidget {
  const MedHomeScreen({super.key});

  @override
  State<MedHomeScreen> createState() => _MedHomeScreenState();
}

class _MedHomeScreenState extends State<MedHomeScreen> {
  String userName = "Utilisateur";

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      final doc =
          await FirebaseFirestore.instance
              .collection('utilisateurs')
              .doc(uid)
              .get();
      setState(() {
        userName = doc.data()?['nom'] ?? "Utilisateur";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bienvenue, $userName"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
        foregroundColor: Colors.white,
      ),
      drawer: const CustomDrawerMed(),
      body: Container(
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: [
            _buildCard(
              context,
              Icons.note_alt,
              "Nouvelle ordonnance",
              "/addor",
              Colors.green.shade100,
            ),
            _buildCard(
              context,
              Icons.history,
              "Historique",
              "/med-hist",
              Colors.orange.shade100,
            ),
            _buildCard(
              context,
              Icons.qr_code,
              "Scanner QR",
              "/scan",
              Colors.pink.shade100,
            ),
            _buildCard(
              context,
              Icons.person,
              "Mon profil",
              "/profil",
              Colors.blueGrey.shade100,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey.shade50,
    );
  }

  Widget _buildCard(
    BuildContext context,
    IconData icon,
    String title,
    String route,
    Color color,
  ) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 42, color: Colors.black87),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
