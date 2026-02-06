import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreditsScreen extends StatelessWidget {
  const CreditsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Créditos', style: GoogleFonts.pressStart2p(color: Colors.red)),
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, 
          children: [
            Text('Programación de Móviles:',
                style: GoogleFonts.pressStart2p(color: Colors.red, fontSize: 12)),
            const SizedBox(height: 10),
            Text('Daniel Ramírez Cabello.',
                style: GoogleFonts.pressStart2p(color: Colors.white, fontSize: 14)),
            const SizedBox(height: 30),
            Text('Profesor guía:',
                style: GoogleFonts.pressStart2p(color: Colors.red, fontSize: 12)),
            const SizedBox(height: 10),
            Text('Francis.',
                style: GoogleFonts.pressStart2p(color: Colors.white, fontSize: 14)),
            const SizedBox(height: 30),
            Text('© 2026 MyGym App',
                style: GoogleFonts.pressStart2p(color: Colors.red, fontSize: 10)),
          ],
        ),
      ),
    );
  }
}
