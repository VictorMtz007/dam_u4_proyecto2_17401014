import 'package:dam_u4_proyecto2_17401014/services/crud_asignacion.dart';
import 'package:flutter/material.dart';

class EditAsignacion extends StatefulWidget {
  const EditAsignacion({Key? key}) : super(key: key);

  @override
  State<EditAsignacion> createState() => _EditAsignacionState();
}

class _EditAsignacionState extends State<EditAsignacion> {
  TextEditingController salonCtrl = TextEditingController();
  TextEditingController edificioCtrl = TextEditingController();
  TextEditingController horarioCtrl = TextEditingController();
  TextEditingController docenteCtrl = TextEditingController();
  TextEditingController materiaCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map? ?? {};
    if (arguments.isNotEmpty) {
      salonCtrl.text = arguments['salon'] ?? '';
      edificioCtrl.text = arguments['edificio'] ?? '';
      horarioCtrl.text = arguments['horario'] ?? '';
      docenteCtrl.text = arguments['docente'] ?? '';
      materiaCtrl.text = arguments['materia'] ?? '';
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Editar Asignacion'),),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: docenteCtrl, decoration: const InputDecoration(labelText: 'Docente:'), autofocus: true,),
              TextField(controller: materiaCtrl, decoration: const InputDecoration(labelText: 'Materia:'),),
              TextField(controller: horarioCtrl, decoration: const InputDecoration(labelText: 'Horario:'),),
              TextField(controller: edificioCtrl, decoration: const InputDecoration(labelText: 'Edifico:'),),
              TextField(controller: salonCtrl, decoration: const InputDecoration(labelText: 'Salon:'),),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: () async {
                await updateAsignaciones( arguments['uid'],
                    salonCtrl.text, edificioCtrl.text, horarioCtrl.text, docenteCtrl.text, materiaCtrl.text
                ).then((_) {
                  Navigator.pop(context);
                });
              }, child: const Text("Actualizar"))
            ],
          ),
        ),
      ),
    );
  }
}
