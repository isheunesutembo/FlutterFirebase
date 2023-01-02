import 'package:firebase_core/firebase_core.dart';
import 'package:firebasegooglesignin/Repository/authrepository.dart';
import 'package:firebasegooglesignin/UI/home.dart';
import 'package:firebasegooglesignin/UI/login.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {'/login': (context) => LogIn(), '/home': (context) => Home()},
        home: StreamBuilder(
          stream: AuthRepository().authStateChanges,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              return Home();
            }
            return LogIn();
          },
        ));
  }
}
