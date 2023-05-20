import 'package:dam_u4_proyecto2_17401014/services/crud_asignacion.dart';
import 'package:flutter/material.dart';

class AddAsignacion extends StatefulWidget {
  const AddAsignacion({Key? key}) : super(key: key);

  @override
  State<AddAsignacion> createState() => _AddAsignacionState();
}

class _AddAsignacionState extends State<AddAsignacion> {
  TextEditingController salonCtrl = TextEditingController();
  TextEditingController edificioCtrl = TextEditingController();
  TextEditingController horarioCtrl = TextEditingController();
  TextEditingController docenteCtrl = TextEditingController();
  TextEditingController materiaCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nueva Asignacion'),),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: docenteCtrl, decoration: const InputDecoration(hintText: 'Nombre del Docente', labelText: 'Docente:'), autofocus: true,),
              TextField(controller: materiaCtrl, decoration: const InputDecoration(hintText: 'Nombre de la Materia:', labelText: 'Materia:'),),
              TextField(controller: horarioCtrl, decoration: const InputDecoration(hintText: 'Horario de la Materia', labelText: 'Horario:'),),
              TextField(controller: edificioCtrl, decoration: const InputDecoration(hintText: 'Edificio Donde se Imparte la Materia', labelText: 'Edificio:'),),
              TextField(controller: salonCtrl, decoration: const InputDecoration(hintText: 'Salon Donde se Imparte la Materia', labelText: 'Salon:'),),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: () async {
                await addAsignaciones(
                    salonCtrl.text, edificioCtrl.text, horarioCtrl.text, docenteCtrl.text, materiaCtrl.text
                ).then((_) {
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
