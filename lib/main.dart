import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
    	WidgetsFlutterBinding.ensureInitialized();
  	await Firebase.initializeApp(
    	options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}	

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyGym',
      theme: ThemeData(
        primaryColor: Colors.red,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red),
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'Montserrat', 
      ),
      home: const SplashScreen(),
    );
  }
}
