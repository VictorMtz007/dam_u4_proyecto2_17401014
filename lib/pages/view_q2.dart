import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dam_u4_proyecto2_17401014/services/crq_asistencia.dart';
import 'package:flutter/material.dart';

class ViewQ2 extends StatefulWidget {
  const ViewQ2({Key? key}) : super(key: key);

  @override
  State<ViewQ2> createState() => _ViewQ2State();
}

class _ViewQ2State extends State<ViewQ2> {
  DateTime fechaCtrl = DateTime.now();
  DateTime horaCtrl = DateTime.now();
  late String fechaHoraI;
  late String fechaHoraF;
  late DateTime dateTimeI;
  late DateTime dateTimeF;

  @override
  void initState() {
    // TODO: implement initState
    // Fecha y Hora Actual
    super.initState();
    fechaHoraI =
    'Fecha: ${fechaCtrl.day.toString() +'-'+ fechaCtrl.month.toString() +'-'+ fechaCtrl.year.toString()} '
        '/ Hora: ${horaCtrl.hour.toString() +':'+ horaCtrl.minute.toString()}';
    fechaHoraF =
    'Fecha: ${fechaCtrl.day.toString() +'-'+ fechaCtrl.month.toString() +'-'+ fechaCtrl.year.toString()} '
        '/ Hora: ${horaCtrl.hour.toString() +':'+ horaCtrl.minute.toString()}';
    dateTimeI = DateTime(fechaCtrl.year,fechaCtrl.month,fechaCtrl.day,horaCtrl.hour,horaCtrl.minute);
    dateTimeF = DateTime(fechaCtrl.year,fechaCtrl.month,fechaCtrl.day,horaCtrl.hour,horaCtrl.minute);
  }

  Future<List<Map<String, dynamic>>>? asistFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Q2: Asistencia por Rango de Fechas"),),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Text('Seleccione el rango a buscar'),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Desde la"),
                TextButton(onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context, initialDate: fechaCtrl,
                    firstDate: DateTime(2023,5), lastDate: DateTime(2222),
                  );
                  final TimeOfDay? picked2 = await showTimePicker(
                    context: context, initialTime: TimeOfDay.fromDateTime(horaCtrl),
                  );
                  if ((picked != null && picked != fechaCtrl) || (picked2 != null && picked2 != horaCtrl)) {
                    setState(() {
                      //Seleccionar Hora y Fecha Nueva
                      fechaHoraI =
                        'Fecha: ${picked!.day.toString() +'-'+ picked.month.toString() +'-'+ picked.year.toString()} '
                        '/ Hora: ${picked2!.hour.toString() +':'+ picked2.minute.toString()}';
                      dateTimeI = DateTime(picked.year,picked.month,picked.day,picked2.hour,picked2.minute);
                      });
                    }
                  }, child: Text(fechaHoraI)),
                ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Hasta la"),
                TextButton(onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context, initialDate: fechaCtrl,
                    firstDate: DateTime(2023,5), lastDate: DateTime(2222),
                  );
                  final TimeOfDay? picked2 = await showTimePicker(
                    context: context, initialTime: TimeOfDay.fromDateTime(horaCtrl),
                  );
                  if ((picked != null && picked != fechaCtrl) || (picked2 != null && picked2 != horaCtrl)) {
                    setState(() {
                      //Seleccionar Hora y Fecha Nueva
                      fechaHoraF =
                      'Fecha: ${picked!.day.toString() +'/'+ picked.month.toString() +'/'+ picked.year.toString()} '
                      '/ Hora: ${picked2!.hour.toString() +':'+ picked2.minute.toString()}';
                      dateTimeF = DateTime(picked.year,picked.month,picked.day,picked2.hour,picked2.minute);
                    });
                  }
                }, child: Text(fechaHoraF)),
              ],
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              setState(() {
                asistFuture = getAsistencias_RFechas(dateTimeI, dateTimeF);
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
                  return Center(child: Text("Error al encontrar a datos entre ${dateTimeI} y ${dateTimeF}"),);
                }else{
                  final asistencias = snapshot.data ?? [];
                  print(asistencias);
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: asistencias.length,
                      itemBuilder: (context,index){
                        final asistencia=asistencias[index];
                        return ListTile(
                          title: Text('Revisor: ${asistencia['revisor']}'),
                          subtitle: Text('${(asistencia['fecha/hora']) ?? 'No disponible'}'),
                        );
                      });
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
