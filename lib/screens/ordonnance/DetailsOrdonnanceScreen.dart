import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailsOrdonnanceScreen extends StatefulWidget {
  final Map<String, dynamic> ordonnanceData;
  final DateTime date;

  const DetailsOrdonnanceScreen({
    super.key,
    required this.ordonnanceData,
    required this.date,
  });

  @override
  State<DetailsOrdonnanceScreen> createState() =>
      _DetailsOrdonnanceScreenState();
}

class _DetailsOrdonnanceScreenState extends State<DetailsOrdonnanceScreen> {
  String medecinNom = 'Chargement...';

  @override
  void initState() {
    super.initState();
    fetchMedecinNom();
  }

  Future<void> fetchMedecinNom() async {
    final medecinId = widget.ordonnanceData['medecinId'];
    if (medecinId != null && medecinId.isNotEmpty) {
      final doc =
          await FirebaseFirestore.instance
              .collection('utilisateurs')
              .doc(medecinId)
              .get();
      if (doc.exists) {
        setState(() {
          medecinNom = doc['nom'] ?? 'Nom inconnu';
        });
      } else {
        setState(() {
          medecinNom = 'Médecin inconnu';
        });
      }
    } else {
      setState(() {
        medecinNom = 'Médecin inconnu';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final medicaments = widget.ordonnanceData['medicaments'] as List<dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Détails de l'ordonnance"),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Date : ${widget.date.toLocal().toString().split('.')[0]}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Médecin : $medecinNom",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Médicaments :",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ...medicaments.map(
                  (med) => Card(
                    color: Colors.green.shade50,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      title: Text(
                        med['name'] ?? 'Nom inconnu',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "${med['doseParJour']} fois/jour pendant ${med['dureeJours']} jours",
                      ),
                      leading: const Icon(
                        Icons.medication,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
