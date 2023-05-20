import 'package:dam_u4_proyecto2_17401014/pages/view_asistencia.dart';
import 'package:dam_u4_proyecto2_17401014/services/crud_asignacion.dart';
import 'package:flutter/material.dart';

class ViewAsignacion extends StatefulWidget {
  const ViewAsignacion({Key? key}) : super(key: key);

  @override
  State<ViewAsignacion> createState() => _ViewAsignacionState();
}

class _ViewAsignacionState extends State<ViewAsignacion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Asignacion"),),
      body: FutureBuilder(
          future: getAsignaciones(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    onDismissed: (direction) async {
                      await deleteAsignaciones(snapshot.data?[index]['uid']);
                    },
                    confirmDismiss: (direction) async {
                      bool result = false;
                      result = await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("¿Estas seguro de querer eliminar a ${snapshot.data?[index]['docente']}?"),
                              actions: [
                                TextButton(onPressed: () {
                                  Navigator.pop(context, false);
                                }, child: const Text("NO, Cancelar")),
                                TextButton(onPressed: () {
                                  Navigator.pop(context, true);
                                }, child: const Text("Si, Eliminar Ahora")),
                              ],
                            );
                          }
                      );
                      return result;
                    },
                    background: Container(
                        child: const Icon(Icons.delete),
                        color: Colors.red
                    ),
                    key: Key(snapshot.data?[index]['uid']),
                    child: InkWell(
                      onTap: () async {
                        await Navigator.pushNamed(context, '/editAsign', arguments: {
                          "salon": snapshot.data?[index]['salon'],
                          "edificio": snapshot.data?[index]['edificio'],
                          "horario": snapshot.data?[index]['horario'],
                          "docente": snapshot.data?[index]['docente'],
                          "materia": snapshot.data?[index]['materia'],
                          "uid": snapshot.data?[index]['uid'],
                        });
                        setState(() {});
                      },
                      onLongPress: () async {
                        await Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAsistencia(asistID: snapshot.data?[index]['uid'] ?? ''),),);
                      },
                      child: ListTile(
                        title: Text(snapshot.data?[index]['docente']),
                        subtitle: Row(
                          children: [
                            Text(
                              'Materia: ${snapshot.data?[index]['materia'] ?? 'No se especifica'} \n'
                              'Horario: ${snapshot.data?[index]['horario'] ?? 'No se especifica'} \n'
                              'Edificio: ${snapshot.data?[index]['edificio'] ?? 'No se especifica'} \n'
                              'Salon: ${snapshot.data?[index]['salon'] ?? 'No se especifica'}'
                            ),
                          ],
                        ),
                      ),
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
          await Navigator.pushNamed(context, '/addAsign');
          setState(() {});
        }, child: const Icon(Icons.add),
      ),
    );
  }
}
