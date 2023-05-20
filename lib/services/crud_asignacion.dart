import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore DB = FirebaseFirestore.instance;

Future<List> getAsignaciones() async {
  List asignaciones = [];
  QuerySnapshot querySnapshot = await DB.collection('asignacion').get();
  for (var doc in querySnapshot.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final asign = {
      "salon": data['salon'],
      "edificio": data['edificio'],
      "horario": data['horario'],
      "docente": data['docente'],
      "materia": data['materia'],
      "uid": doc.id,
    };
    asignaciones.add(asign);
  }
  return asignaciones;
}

Future<void> addAsignaciones(
    String salon, String edificio, String horario,
    String docente, String materia
    ) async {
  await DB.collection('asignacion').add(
      {
        "salon": salon,
        "edificio": edificio,
        "horario": horario,
        "docente": docente,
        "materia": materia,
      }
  );
}

Future<void> updateAsignaciones( String uid,
    String Nsalon, String Nedificio, String Nhorario,
    String Ndocente, String Nmateria
    ) async {
  await DB.collection('asignacion').doc(uid).set({
    'salon': Nsalon, 'edificio': Nedificio, 'horario': Nhorario,
    'docente': Ndocente, 'materia': Nmateria
  });
}

Future<void> deleteAsignaciones( String uid ) async {
  await DB.collection('asignacion').doc(uid).delete();
}