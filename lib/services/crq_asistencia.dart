import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore DB = FirebaseFirestore.instance;

Future<List> getAsistencias(String asistID) async {
  List asistencias = [];
  QuerySnapshot querySnapshot = await DB.collection('asignacion').doc(asistID).collection('asistencia').get();
  for (var doc in querySnapshot.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final asist = {
      "fecha/hora": data['fecha/hora'],
      "revisor": data['revisor'],
      "uid": doc.id,
    };
    asistencias.add(asist);
  }
  return asistencias;
}

Future<void> addAsistencias(String asistID, Map<String, dynamic> asistData) async{
  await DB.collection('asignacion').doc(asistID).collection('asistencia').add(asistData);
}
//----------------------- CONSULTAS -----------------------//
// Q1: Asistencias de un docente determinado
Future<List<Map<String, dynamic>>> getAsistencias_Docente(String Docente) async {
  List<Map<String, dynamic>> asistenciasDocente = [];
  QuerySnapshot querySnapshot = await DB.collection('asignacion').where('docente', isEqualTo: Docente).get();
  for (var doc in querySnapshot.docs) {
    QuerySnapshot asistDocSnapshot = await doc.reference.collection('asistencia').get();
    asistenciasDocente.addAll(asistDocSnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList());
  }
  return asistenciasDocente;
}
// Q2: Asistencias de un rango de fechas (todos los maestros en todos los salones)
Future<List<Map<String, dynamic>>> getAsistencias_RFechas(DateTime FInicio, DateTime FFin) async {
  List<Map<String, dynamic>> asistenciasRFechas = [];
  QuerySnapshot querySnapshot = await DB.collection('asignacion').get();
  for (var doc in querySnapshot.docs) {
    QuerySnapshot asistRFSnapshot = await doc.reference.collection('asistencia').where('fecha/hora', isGreaterThanOrEqualTo: FInicio)
        .where('fecha/hora', isLessThanOrEqualTo: FFin).get();
    asistenciasRFechas.addAll(asistRFSnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList());
  }
  return asistenciasRFechas;
}
// Q3: Asistencias en rango de fechas (por edificio) mostrando todos los maestros
Future<List<Map<String, dynamic>>> getAsistencias_RFechasEd(DateTime FInicio, DateTime FFin, String Edificio) async {
  List<Map<String, dynamic>> asistenciasRFE = [];
  QuerySnapshot querySnapshot = await DB.collection('asignacion').where('edificio', isEqualTo: Edificio).get();
  for (var doc in querySnapshot.docs) {
    QuerySnapshot asistRFESnapshot = await doc.reference.collection('asistencia').where('fecha/hora', isGreaterThanOrEqualTo: FInicio)
        .where('fecha/hora', isLessThanOrEqualTo: FFin).get();
    asistenciasRFE.addAll(asistRFESnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList());
  }
  return asistenciasRFE;
}
//Q4: Asistentes por Revisor
Future<List<Map<String, dynamic>>> getAsistencias_Revisor(String Revisor) async {
  List<Map<String, dynamic>> asistencias = [];
  QuerySnapshot querySnapshot = await DB.collection('asignacion').get();
  for (var doc in querySnapshot.docs) {
    QuerySnapshot asistRevSnapshot = await doc.reference.collection('asistencia').where('revisor', isEqualTo: Revisor).get();
    asistencias.addAll(asistRevSnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList());
  }
  return asistencias;
}