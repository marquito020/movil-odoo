import 'package:flutter/material.dart';
import 'package:movil_academico/widgets/drawer_widget.dart';
import 'package:nb_utils/nb_utils.dart';

import '../services/colegio_service.dart';

class CursoScreen extends StatefulWidget {
  const CursoScreen({super.key});

  @override
  State<CursoScreen> createState() => _CursoScreenState();
}

class _CursoScreenState extends State<CursoScreen> {
  List<Map<String, dynamic>?> cursos = [];

  ColegioService colegioService = ColegioService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  Future<void> init() async {
    cursos = await colegioService.getCursos();
    print(cursos);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cursos'),
      ),
      drawer: DrawerWidget(),
      body: ListView.builder(
        itemCount: cursos.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: boxDecorationRoundedWithShadow(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cursos[index]!['name']),
                8.height,
                Text(cursos[index]!['nivel']),
                8.height,
                Text(cursos[index]!['grado']),
                8.height,
                Text(cursos[index]!['turno']),
              ],
            ),
          );
        },
      ),
    );
  }
}
