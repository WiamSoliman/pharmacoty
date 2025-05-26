import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Ajout pour récupérer l'UID
import 'package:pharmacoty/widget/custom.drawer.widget.med.dart';

class AddOrdonnanceScreen extends StatefulWidget {
  const AddOrdonnanceScreen({super.key});

  @override
  State<AddOrdonnanceScreen> createState() => _AddOrdonnanceScreenState();
}

class _AddOrdonnanceScreenState extends State<AddOrdonnanceScreen> {
  final cnssController = TextEditingController();
  final patientNomController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> medicaments = [];

  void _addMedicament() {
    setState(() {
      medicaments.add({
        'medicineId': '', // Tu peux laisser vide ou utiliser un ID existant
        'name': '',
        'doseParJour': 1,
        'dureeJours': 1,
      });
    });
  }

  void _removeMedicament(int index) {
    setState(() {
      medicaments.removeAt(index);
    });
  }

  Future<void> _saveOrdonnance() async {
    if (!_formKey.currentState!.validate()) return;

    final cnss = cnssController.text.trim();
    final patientNom = patientNomController.text.trim();
    final date = DateTime.now();
    final medecinId =
        FirebaseAuth.instance.currentUser?.uid ?? ''; // Récupère l'UID

    final ordonnanceData = {
      'cnss': cnss,
      'patientNom': patientNom,
      'medecinId': medecinId,
      'date': date,
      'medicaments':
          medicaments, // Enregistre tous les médicaments sous forme de liste
    };

    try {
      await FirebaseFirestore.instance
          .collection('ordonnances')
          .add(ordonnanceData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ordonnance enregistrée avec succès !')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de l\'enregistrement : $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nouvelle Ordonnance',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      drawer: const CustomDrawerMed(),
      body: Container(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: cnssController,
                decoration: const InputDecoration(labelText: "CNSS du patient"),
                validator: (value) => value!.isEmpty ? 'Champ requis' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: patientNomController,
                decoration: const InputDecoration(labelText: "Nom du patient"),
                validator: (value) => value!.isEmpty ? 'Champ requis' : null,
              ),
              const SizedBox(height: 16),
              const Text(
                "Médicaments",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ...medicaments.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> med = entry.value;
                return Card(
                  child: Container(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Nom du médicament",
                          ),
                          onChanged: (val) => med['name'] = val,
                          validator:
                              (val) => val!.isEmpty ? 'Champ requis' : null,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "ID du médicament (facultatif)",
                          ),
                          onChanged: (val) => med['medicineId'] = val,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Posologie (fois par jour)",
                          ),
                          keyboardType: TextInputType.number,
                          onChanged:
                              (val) =>
                                  med['doseParJour'] = int.tryParse(val) ?? 1,
                          validator:
                              (val) => val!.isEmpty ? 'Champ requis' : null,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Durée (jours)",
                          ),
                          keyboardType: TextInputType.number,
                          onChanged:
                              (val) =>
                                  med['dureeJours'] = int.tryParse(val) ?? 1,
                          validator:
                              (val) => val!.isEmpty ? 'Champ requis' : null,
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _removeMedicament(index),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
              ElevatedButton(
                onPressed: _addMedicament,
                child: const Text("Ajouter un médicament"),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveOrdonnance,
                child: const Text("Enregistrer l'ordonnance"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
