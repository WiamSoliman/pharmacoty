import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharmacoty/screens/ordonnance/DetailsOrdonnanceScreen.dart';

class OrdonnancesPatientScreen extends StatefulWidget {
  final String cnss;

  const OrdonnancesPatientScreen({super.key, required this.cnss});

  @override
  State<OrdonnancesPatientScreen> createState() =>
      _OrdonnancesPatientScreenState();
}

class _OrdonnancesPatientScreenState extends State<OrdonnancesPatientScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ordonnances du patient",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance
                .collection('ordonnances')
                .where('cnss', isEqualTo: widget.cnss)
                .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Aucune ordonnance trouvée."));
          }

          final ordonnances = snapshot.data!.docs;

          return ListView.builder(
            itemCount: ordonnances.length,
            itemBuilder: (context, index) {
              final data = ordonnances[index].data() as Map<String, dynamic>;
              final date = (data['date'] as Timestamp).toDate();
              final medicaments = data['medicaments'] as List<dynamic>;

              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text("Ordonnance du ${date.toLocal()}"),
                  subtitle: Text("${medicaments.length} médicaments"),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    // Navigation vers la page détaillée
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => DetailsOrdonnanceScreen(
                              ordonnanceData: data,
                              date: date,
                            ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
