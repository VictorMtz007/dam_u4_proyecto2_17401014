import 'package:dam_u4_proyecto2_17401014/pages/add_asignacion.dart';
import 'package:dam_u4_proyecto2_17401014/pages/edit_asignacion.dart';
import 'package:dam_u4_proyecto2_17401014/pages/inicio.dart';
import 'package:dam_u4_proyecto2_17401014/pages/view_asignacion.dart';
import 'package:flutter/material.dart';
//FIREBASE
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PresenTec',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Inicio(),
        '/asign': (context) => const ViewAsignacion(),
        '/editAsign': (context) => const EditAsignacion(),
        '/addAsign': (context) => const AddAsignacion(),
      },
    );
  }
}