import 'package:flutter/material.dart';
import 'package:movil_academico/services/colegio_service.dart';
import 'package:nb_utils/nb_utils.dart';

class AulaScreen extends StatefulWidget {
  const AulaScreen({super.key});

  @override
  State<AulaScreen> createState() => _AulaScreenState();
}

class _AulaScreenState extends State<AulaScreen> {
  List<Map<String, dynamic>?> aulas = [];

  ColegioService colegioService = ColegioService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  Future<void> init() async {
    aulas = await colegioService.getAulas();
    print(aulas);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aulas'),
      ),
      body: ListView.builder(
        itemCount: aulas.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: boxDecorationRoundedWithShadow(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Aula: ${aulas[index]!['id']}"),
                8.height,
                Text("Numero: ${aulas[index]!['numero']}"),
                8.height,
                Text("Nombre: " + aulas[index]!['name']),
              ],
            ),
          );
        },
      ),
    );
  }
}
