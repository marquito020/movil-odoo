import 'package:flutter/material.dart';
import 'package:movil_academico/services/colegio_service.dart';
import 'package:nb_utils/nb_utils.dart';

class MateriaScreen extends StatefulWidget {
  const MateriaScreen({super.key});

  @override
  State<MateriaScreen> createState() => _MateriaScreenState();
}

class _MateriaScreenState extends State<MateriaScreen> {
  List<Map<String, dynamic>?> materias = [];
  ColegioService colegioService = ColegioService();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    setState(() {
      _loading = true;
    });

    // Fetch the data
    List<Map<String, dynamic>?> fetchedMaterias =
        await colegioService.getMaterias();

    // Ensure the widget is still mounted before calling setState
    if (!mounted) return;

    setState(() {
      materias = fetchedMaterias;
      _loading = false;
    });
  }

  @override
  void dispose() {
    // Cancel any ongoing operations if needed
    // Example: If using a timer or a stream, cancel it here.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Materias'),
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: materias.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: boxDecorationRoundedWithShadow(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nombre: ${materias[index]!['name']}"),
                      8.height,
                      Text("Curso: ${materias[index]!['curso_id'][1]}"),
                      8.height,
                      Text("Profesor: ${materias[index]!['profesor_id'][1]}"),
                      8.height,
                      Text("Aula: ${materias[index]!['aula_id'][1]}"),
                      8.height,
                      Text("Horario: ${materias[index]!['horario_id'][1]}"),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
