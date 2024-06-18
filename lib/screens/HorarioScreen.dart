import 'package:flutter/material.dart';
import 'package:movil_academico/services/colegio_service.dart';
import 'package:nb_utils/nb_utils.dart';

class HorarioScreen extends StatefulWidget {
  const HorarioScreen({super.key});

  @override
  State<HorarioScreen> createState() => _HorarioScreenState();
}

class _HorarioScreenState extends State<HorarioScreen> {
  List<Map<String, dynamic>?> horarios = [];

  ColegioService colegioService = ColegioService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  Future<void> init() async {
    horarios = await colegioService.getHorarios();
    print(horarios);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Horarios'),
      ),
      body: ListView.builder(
        itemCount: horarios.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: boxDecorationRoundedWithShadow(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Nombre: ${horarios[index]!['name']}"),
                8.height,
                Text("Hora Inicio: ${horarios[index]!['hora_inicio']}"),
                8.height,
                Text("Hora Fin: ${horarios[index]!['hora_fin']}"),
              ],
            ),
          );
        },
      ),
    );
  }
}
