import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Se connecter avec email et mot de passe
  Future<UserCredential> signIn(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Déconnexion
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Obtenir l'utilisateur courant
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
