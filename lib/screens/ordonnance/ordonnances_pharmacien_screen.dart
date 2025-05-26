import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharmacoty/screens/ordonnance/details_ordonnance_pharmacien_screen.dart';

class PharmacienOrdonnancesScreen extends StatefulWidget {
  final String cnss;
  const PharmacienOrdonnancesScreen({super.key, required this.cnss});

  @override
  State<PharmacienOrdonnancesScreen> createState() =>
      _PharmacienOrdonnancesScreenState();
}

class _PharmacienOrdonnancesScreenState
    extends State<PharmacienOrdonnancesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ordonnances Patient"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance
                .collection('ordonnances')
                .where('cnss', isEqualTo: widget.cnss)
                .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return const Center(child: CircularProgressIndicator());

          final ordonnances = snapshot.data!.docs;

          return ListView.builder(
            itemCount: ordonnances.length,
            itemBuilder: (context, index) {
              final data = ordonnances[index].data() as Map<String, dynamic>;
              final date = (data['date'] as Timestamp).toDate();

              return Card(
                child: ListTile(
                  title: Text("Ordonnance du ${date.toLocal()}"),
                  subtitle: Text("${data['medicaments'].length} médicaments"),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => PharmacienDetailsOrdonnanceScreen(
                              ordonnanceId: ordonnances[index].id,
                              data: data,
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
