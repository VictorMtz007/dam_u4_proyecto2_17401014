import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dam_u4_proyecto2_17401014/services/crq_asistencia.dart';
import 'package:flutter/material.dart';

class ViewQ4 extends StatefulWidget {
  const ViewQ4({Key? key}) : super(key: key);

  @override
  State<ViewQ4> createState() => _ViewQ4State();
}

class _ViewQ4State extends State<ViewQ4> {
  TextEditingController revisorCrtl = TextEditingController();
  Future<List<Map<String, dynamic>>>? asistFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Q4: Asistencias por Revisor"),),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            TextField(
              controller: revisorCrtl,
              decoration: InputDecoration(labelText: "Nombre del Revisor"),
            ),
            Padding(padding: EdgeInsets.all(15)),
            ElevatedButton(onPressed: (){
              setState(() {
                asistFuture = getAsistencias_Revisor(revisorCrtl.text);
              });
            }, child: Text("Buscar")),
            SizedBox(height: 20,),
            Divider(color: Colors.teal, height: 20,),
            Expanded(child: FutureBuilder<List<Map<String, dynamic>>>(
              future: asistFuture,
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator(),);
                }else if(snapshot.hasError){
                  return Center(child: Text("Error al encontrar a ${revisorCrtl.text}"),);
                }else{
                  final asistencias = snapshot.data ?? [];
                  return ListView.builder(
                      itemCount: asistencias.length,
                      itemBuilder: (context,index){
                        final asistencia=asistencias[index];
                        return ListTile(
                          title: Text('Revisor: ${asistencia['revisor']}'),
                          subtitle: Text('${(snapshot.data?[index]['fecha/hora'] as Timestamp).toDate().toString() ?? 'No se especifica'}'),
                        );
                      });
                }
              },
            ),),
          ],
        ),
      ),
    );
  }
}
