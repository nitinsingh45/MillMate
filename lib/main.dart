import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:millmate/firebase_options.dart';
import 'package:millmate/phone.dart';
import 'package:millmate/screens/home.dart';
import 'package:millmate/verify.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

/*class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHome(),
    );
  }
}*/
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => MyPhone(),
        '/home': (context) => MyHome(),
        'MyVerify': (context) => MyVerify(),
      },
    );
  }
}
