import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _goToLogin();
  }

  void _goToLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.pushReplacementNamed(context, 'login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset('assets/images/logo.jpg', height: 150),

            const SizedBox(height: 20), // Espacio
            const Text(
              'MY GYM',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
                letterSpacing:
                    3, // Separo un poco las letras para que quede elegante
              ),
            ),

            const SizedBox(height: 40),
            // Ruedita de carga
            const CircularProgressIndicator(color: Colors.redAccent),
          ],
        ),
      ),
    );
  }
}
