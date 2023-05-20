import 'package:dam_u4_proyecto2_17401014/services/crq_asistencia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewQ1 extends StatefulWidget {
  const ViewQ1({Key? key}) : super(key: key);

  @override
  State<ViewQ1> createState() => _ViewQ1State();
}

class _ViewQ1State extends State<ViewQ1> {
  TextEditingController docenteCtrl = TextEditingController();
  Future<List<Map<String, dynamic>>>? asistFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Q1: Asistencia de un Docente"),),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            TextField(
              controller: docenteCtrl,
              decoration: InputDecoration(labelText: "Nombre del Docente"),
            ),
            Padding(padding: EdgeInsets.all(15)),
            ElevatedButton(onPressed: (){
              setState(() {
                asistFuture = getAsistencias_Docente(docenteCtrl.text);
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
                  return Center(child: Text("Error al encontrar a ${docenteCtrl.text}"),);
                }else{
                  final asistencias = snapshot.data ?? [];
                  return ListView.builder(
                      itemCount: asistencias.length,
                      itemBuilder: (context,index){
                        final asistencia=asistencias[index];
                        return ListTile(
                          title: Text('Docente: ${docenteCtrl.text}'),
                          subtitle: Row(
                            children: [
                              Text('Revisor: ${asistencia['revisor']} \n'
                                   'Fecha/Hora: ${(snapshot.data?[index]['fecha/hora'] as Timestamp).toDate().toString() ?? 'No se especifica'}'
                              ),
                            ],
                          ),
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
