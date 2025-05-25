import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Récupérer le rôle d'un utilisateur par UID
  Future<String> getUserRole(String uid) async {
    final doc = await _firestore.collection('utilisateurs').doc(uid).get();
    final data = doc.data();
    return data?['role'] ?? '';
  }

  /// Créer un document utilisateur lors de l'inscription
  Future<void> createUser(
    String uid,
    String email,
    String nom,
    String role,
  ) async {
    await _firestore.collection('utilisateurs').doc(uid).set({
      'email': email,
      'nom': nom,
      'role': role,
    });
  }

  /// Récupérer le document complet d'un utilisateur
  Future<Map<String, dynamic>?> getUserData(String uid) async {
    final doc = await _firestore.collection('utilisateurs').doc(uid).get();
    return doc.data();
  }
}
