import 'package:dam_u4_proyecto2_17401014/services/crq_asistencia.dart';
import 'package:flutter/material.dart';

class ViewQ3 extends StatefulWidget {
  const ViewQ3({Key? key}) : super(key: key);

  @override
  State<ViewQ3> createState() => _ViewQ3State();
}

class _ViewQ3State extends State<ViewQ3> {
  DateTime fechaCtrl = DateTime.now();
  DateTime horaCtrl = DateTime.now();
  TextEditingController edificioCtrl = TextEditingController();
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
      appBar: AppBar(title: const Text("Q3: Asistencia por Rango de Fechas y Edificio"),),
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
            Text('Escriba el Edificio a buscar'),
            SizedBox(height: 20,),
            TextField(
              controller: edificioCtrl,
              decoration: InputDecoration(labelText: "Nombre del Edificio"),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              setState(() {
                asistFuture = getAsistencias_RFechasEd(dateTimeI, dateTimeF, edificioCtrl.text);
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
                  return Center(child: Text("Error al encontrar a datos entre ${dateTimeI} y ${dateTimeF} en el edificio ${edificioCtrl.text}"),);
                }else{
                  final asistencias = snapshot.data ?? [];
                  print(asistencias);
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: asistencias.length,
                      itemBuilder: (context,index){
                        final asistencia=asistencias[index];
                        return ListTile(
                          title: Text('Edificio: ${edificioCtrl.text}'),
                          subtitle: Column(
                            children: [
                              Text('Revisor: ${asistencia['revisor']} \n'
                                   'Fecha/Hora: ${(asistencia['fecha/hora']) ?? 'No disponible'}'
                              ),
                            ],
                          ),
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
