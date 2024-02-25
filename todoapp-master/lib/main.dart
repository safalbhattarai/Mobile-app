import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:todoapp/Service/Auth_Service.dart';
import 'package:todoapp/pages/AddTodo.dart';
import 'package:todoapp/pages/HomePage.dart';
import 'package:todoapp/pages/SignInPage.dart';
import 'package:todoapp/pages/SignUpPage.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget currentPage = SignUpPage();
  AuthClass authClass = AuthClass();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    String? token = await authClass.getToken();

    print("token" + token.toString());
    if (FirebaseAuth.instance.currentUser != null) {
      setState(() {
        currentPage = HomePage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
          splash: 'assets/logo.png',
          duration: 2000,
          splashTransition: SplashTransition.rotationTransition,
          backgroundColor: Colors.black87,
          nextScreen: currentPage),
    );
  }
}
