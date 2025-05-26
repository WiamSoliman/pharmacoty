import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharmacoty/screens/ordonnance/OrdonnancesPatientScreen.dart';
import 'package:pharmacoty/widget/custom.drawer.widget.patient.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({super.key});

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  String cnss = "";
  String userName = "";

  @override
  void initState() {
    super.initState();
    _loadPatientInfo();
  }

  Future<void> _loadPatientInfo() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      final doc =
          await FirebaseFirestore.instance
              .collection('utilisateurs')
              .doc(uid)
              .get();
      setState(() {
        cnss = doc.data()?['cnss'] ?? "CNSS non trouvé";
        userName = doc.data()?['nom'] ?? "Patient";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bienvenue, $userName",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      drawer: CustomDrawerPatient(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Votre code CNSS sous forme de QR",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            cnss.isNotEmpty
                ? QrImageView(data: cnss, version: QrVersions.auto, size: 200)
                : const CircularProgressIndicator(),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrdonnancesPatientScreen(cnss: cnss),
                  ),
                );
              },
              icon: const Icon(Icons.description),
              label: const Text(
                "Mes ordonnances",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
