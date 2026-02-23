import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controladores para leer la entrada de texto
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorMessage = '';
  bool _isLoading = false;

  // Lógica principal de autenticación
  Future<void> _login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    setState(() {
      _errorMessage = '';
      _isLoading = true;
    });

    // MODO OFFLINE: Credenciales obligatorias exigidas en las instrucciones del proyecto
    if ((email == 'usuario' && password == 'usuario') ||
        (email == 'fferban041@g.educaand.es' && password == 'usuario')) {
      _goToHome();
      return;
    }

    // MODO ONLINE: Autenticación mediante Firebase
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (mounted) _goToHome();
    } on FirebaseAuthException catch (e) {
      // Gestión de errores específicos de Firebase
      setState(() {
        if (e.code == 'user-not-found') {
          _errorMessage = 'No existe ese usuario.';
        } else if (e.code == 'wrong-password') {
          _errorMessage = 'Contraseña incorrecta.';
        } else if (e.code == 'invalid-email') {
          _errorMessage = 'El correo no es válido.';
        } else {
          _errorMessage = 'Error: ${e.message}';
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error de conexión. Revisa tu internet.';
      });
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _goToHome() {
    Navigator.pushReplacementNamed(context, 'main_nav');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logotipo de la aplicación
              const Icon(
                Icons.fitness_center,
                size: 80,
                color: Colors.redAccent,
              ),
              const SizedBox(height: 20),
              const Text(
                'MY GYM',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 50),

              // Campo de entrada: Correo Electrónico
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Correo Electrónico / Usuario',
                  labelStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.email, color: Colors.redAccent),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.redAccent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Campo de entrada: Contraseña
              TextField(
                controller: _passwordController,
                obscureText: true, // Oculta los caracteres
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  labelStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.lock, color: Colors.redAccent),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.redAccent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Contenedor dinámico para mensajes de error
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    _errorMessage,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

              // Botón de Inicio de Sesión
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.black,
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.black)
                      : const Text(
                          'ENTRAR',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
