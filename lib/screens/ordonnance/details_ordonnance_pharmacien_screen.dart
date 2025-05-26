import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PharmacienDetailsOrdonnanceScreen extends StatelessWidget {
  final String ordonnanceId;
  final Map<String, dynamic> data;

  const PharmacienDetailsOrdonnanceScreen({
    super.key,
    required this.ordonnanceId,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final medicaments = data['medicaments'] as List<dynamic>;
    final date = (data['date'] as Timestamp).toDate();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Détails Ordonnance"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Date: ${date.toLocal()}"),
            Text("Médecin: ${data['medecinId'] ?? 'Inconnu'}"),
            Text("Patient: ${data['patientNom']}"),
            const SizedBox(height: 16),
            const Text(
              "Médicaments:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ...medicaments.map(
              (med) => ListTile(
                title: Text(med['name']),
                subtitle: Text(
                  "${med['doseParJour']} fois/jour pendant ${med['dureeJours']} jours",
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('ordonnances')
                    .doc(ordonnanceId)
                    .update({'status': 'Servie'});
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Ordonnance servie")),
                );
                Navigator.pop(context);
              },
              icon: const Icon(Icons.check),
              label: const Text("Marquer comme Servie"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Ajouter logique d'envoi commande labo
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Commande labo envoyée")),
                );
              },
              icon: const Icon(Icons.local_shipping),
              label: const Text("Commander au labo"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            ),
          ],
        ),
      ),
    );
  }
}
