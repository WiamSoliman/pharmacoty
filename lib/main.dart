import 'package:flutter/material.dart';
import 'package:pharmacoty/screens/auth/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const PharmacotyApp());
}

class PharmacotyApp extends StatelessWidget {
  const PharmacotyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {'/': (context) => const LoginScreen()},
      theme: ThemeData(
        textTheme: const TextTheme(bodyLarge: TextStyle(fontSize: 22)),
        indicatorColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green, // Garder seulement seedColor
        ),
        useMaterial3: true, // Optionnel mais recommandé
      ),
    );
  }
}
