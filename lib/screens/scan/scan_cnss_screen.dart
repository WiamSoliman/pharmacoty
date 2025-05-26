import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pharmacoty/screens/ordonnance/ordonnances_pharmacien_screen.dart';

class ScanCnssScreen extends StatelessWidget {
  const ScanCnssScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scanner QR CNSS")),
      body: MobileScanner(
        onDetect: (capture) {
          final cnss = capture.barcodes.first.rawValue;
          if (cnss != null && cnss.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PharmacienOrdonnancesScreen(cnss: cnss),
              ),
            );
          } else {
            showDialog(
              context: context,
              builder:
                  (context) => AlertDialog(
                    title: const Text("Erreur"),
                    content: const Text("QR code invalide ou vide."),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
            );
          }
        },
      ),
    );
  }
}
