import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dam_u4_proyecto2_17401014/pages/add_asistencia.dart';
import 'package:dam_u4_proyecto2_17401014/services/crq_asistencia.dart';
import 'package:flutter/material.dart';

class ViewAsistencia extends StatefulWidget {
  final String asistID;
  const ViewAsistencia({Key? key, required this.asistID}) : super(key: key);

  @override
  State<ViewAsistencia> createState() => _ViewAsistenciaState();
}

class _ViewAsistenciaState extends State<ViewAsistencia> {

  @override
  Widget build(BuildContext context) {
    String asistID = widget.asistID;

    return Scaffold(
      appBar: AppBar(title: const Text("Asistencias"),),
      body: FutureBuilder(
          future: getAsistencias(widget.asistID),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: ListTile(
                      title: Text(snapshot.data?[index]['revisor'] ?? 'No se especifica' ),
                      subtitle: Text('${(snapshot.data?[index]['fecha/hora'] as Timestamp).toDate().toString() ?? 'No se especifica'}'),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          })
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (builder) => AddAsistencia(asistID: asistID,)));
          setState(() {});
        }, child: const Icon(Icons.add),
      ),
    );
  }
}
