import 'package:dam_u4_proyecto2_17401014/pages/view_asignacion.dart';
import 'package:dam_u4_proyecto2_17401014/pages/view_q1.dart';
import 'package:dam_u4_proyecto2_17401014/pages/view_q2.dart';
import 'package:dam_u4_proyecto2_17401014/pages/view_q3.dart';
import 'package:dam_u4_proyecto2_17401014/pages/view_q4.dart';
import 'package:flutter/material.dart';

class Inicio extends StatefulWidget {
  const Inicio({Key? key}) : super(key: key);

  @override
  State<Inicio> createState() => _InicioState();
}

int _indice = 0;
class _InicioState extends State<Inicio> {

  final List<Widget> _Cambio = [
    ViewAsignacion(),
    ViewQ1(),
    ViewQ2(),
    ViewQ3(),
    ViewQ4(),
  ];

  void alPulsarBNB(int index) {
    setState(() { _indice = index; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _Cambio[_indice],
      bottomNavigationBar: BottomNavigationBar(
        onTap: alPulsarBNB,
        currentIndex: _indice,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.teal[200],
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Asignacion'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: '<Q1>'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: '<Q2>'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: '<Q3>'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: '<Q4>'
          ),
        ],
      ),
    );
  }
}
