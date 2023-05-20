import 'package:dam_u4_proyecto2_17401014/services/crq_asistencia.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddAsistencia extends StatefulWidget {
  final asistID;
  const AddAsistencia({Key? key, required this.asistID}) : super(key: key);

  @override
  State<AddAsistencia> createState() => _AddAsistenciaState();
}

class _AddAsistenciaState extends State<AddAsistencia> {
  DateTime fechaCtrl = DateTime.now();
  DateTime horaCtrl = DateTime.now();
  TextEditingController revisorCtrl = TextEditingController();
  late String fechaHora;
  late DateTime fechaHoraXD;

  @override
  void initState() {
    // TODO: implement initState
    // Fecha y Hora Actual
    super.initState();
    fechaHora =
      'Fecha: ${fechaCtrl.day.toString() +'-'+ fechaCtrl.month.toString() +'-'+ fechaCtrl.year.toString()} '
      '/ Hora: ${fechaCtrl.hour.toString() +':'+ fechaCtrl.minute.toString()}';
    fechaHoraXD = DateTime(fechaCtrl.year,fechaCtrl.month,fechaCtrl.day,horaCtrl.hour,horaCtrl.minute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nueva Asistencia'),),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
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
                    fechaHora =
                        'Fecha: ${picked!.day.toString() +'-'+ picked.month.toString() +'-'+ picked.year.toString()} '
                        '/ Hora: ${picked2!.hour.toString() +':'+ picked2.minute.toString()}';
                    fechaHoraXD = DateTime(picked.year,picked.month,picked.day,picked2.hour,picked2.minute);
                  });
                }
              }, child: Text(fechaHora),),
              TextField(controller: revisorCtrl, decoration: const InputDecoration(hintText: 'Nombre del Revisor', labelText: 'Revisor:'),),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: () async {
                await addAsistencias(widget.asistID, {
                  "fecha/hora": fechaHoraXD,
                  "revisor": revisorCtrl.text,
                }).then((_) {
                  Navigator.pop(context);
                });
              }, child: const Text("Guardar"))
            ],
          ),
        ),
      ),
    );

  }
}
