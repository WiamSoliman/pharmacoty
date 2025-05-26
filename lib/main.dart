import 'package:flutter/material.dart';
import 'package:pharmacoty/screens/auth/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pharmacoty/screens/home/labo_home_screen.dart';
import 'package:pharmacoty/screens/home/med_home_screen.dart';
import 'package:pharmacoty/screens/home/patient_home_screen.dart';
import 'package:pharmacoty/screens/home/pharma_home_screen.dart';
import 'package:pharmacoty/screens/ordonnance/OrdonnancesPatientScreen.dart';
import 'package:pharmacoty/screens/ordonnance/add_ordonnance_screen.dart';
import 'package:pharmacoty/screens/scan/scan_cnss_screen.dart';

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
      routes: {
        '/': (context) => const LoginScreen(),
        '/addor': (context) => const AddOrdonnanceScreen(),
        '/homemed': (context) => const MedHomeScreen(),
        '/homelabo': (context) => const LaboHomeScreen(),
        '/homepa': (context) => const PatientHomeScreen(),
        '/homepharma': (context) => const PharmaHomeScreen(),
        '/scan-cnss': (context) => const ScanCnssScreen(),
      },
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
