import 'package:flutter/material.dart';
import '../../../models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  void _modifierProduit(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Fonction Modifier à implémenter")),
    );
  }

  void _supprimerProduit(BuildContext context, String id) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("Confirmer la suppression"),
            content: const Text("Voulez-vous vraiment supprimer ce produit ?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Annuler"),
              ),
              TextButton(
                onPressed: () async {
                  try {
                    await FirebaseFirestore.instance
                        .collection('produits')
                        .doc(product.id) // ← Ici on utilise produit.id
                        .delete();

                    Navigator.pop(context); // Ferme le dialog
                    Navigator.pop(context); // Reviens à l'écran précédent

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Produit supprimé")),
                    );
                  } catch (e) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Erreur lors de la suppression"),
                      ),
                    );
                  }
                },
                child: const Text(
                  "Supprimer",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }

  Widget _buildInfo(String label, String value) {
    return Card(
      color: Colors.pink.shade50, // Conserve un fond doux si tu veux
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green, // <-- ici on utilise la primaryColor
          ),
        ),
        subtitle: Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.nomProduit, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/modifier-produit',
                arguments: product, // Passe l’objet Product
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _supprimerProduit(context, product.id),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _buildInfo("Identifiant médicament", product.medicineId.toString()),
            _buildInfo("Nom", product.name),
            _buildInfo("Fabricant", product.manufacturer),
            _buildInfo("Ingrédients actifs", product.activeIngredients),
            _buildInfo("Dosage", product.dosage),
            _buildInfo("Formulation", product.formulation),
            _buildInfo(
              "Date d'enregistrement",
              product.registrationDate.toIso8601String(),
            ),
            _buildInfo("Actif", product.isActive ? "Oui" : "Non"),
          ],
        ),
      ),
    );
  }
}
