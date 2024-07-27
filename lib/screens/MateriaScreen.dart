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
  List<Map<String, dynamic>?> filteredMaterias = [];
  ColegioService colegioService = ColegioService();
  bool _loading = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    setState(() {
      _loading = true;
    });

    List<Map<String, dynamic>?> fetchedMaterias =
        await colegioService.getMaterias();

    if (!mounted) return;

    setState(() {
      materias = fetchedMaterias;
      filteredMaterias = fetchedMaterias;
      _loading = false;
    });
  }

  void _filterMaterias(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredMaterias = materias;
      });
    } else {
      setState(() {
        filteredMaterias = materias.where((materia) {
          final name = materia?['name']?.toLowerCase() ?? '';
          final curso = materia?['curso_id']?[1]?.toLowerCase() ?? '';
          final profesor = materia?['profesor_id']?[1]?.toLowerCase() ?? '';
          final aula = materia?['aula_id']?[1]?.toLowerCase() ?? '';
          final horario = materia?['horario_id']?[1]?.toLowerCase() ?? '';

          return name.contains(query.toLowerCase()) ||
              curso.contains(query.toLowerCase()) ||
              profesor.contains(query.toLowerCase()) ||
              aula.contains(query.toLowerCase()) ||
              horario.contains(query.toLowerCase());
        }).toList();
      });
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Materias'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Buscar...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _filterMaterias,
            ),
          ),
        ),
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: filteredMaterias.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: boxDecorationRoundedWithShadow(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nombre: ${filteredMaterias[index]!['name']}"),
                      8.height,
                      Text("Curso: ${filteredMaterias[index]!['curso_id'][1]}"),
                      8.height,
                      Text(
                          "Profesor: ${filteredMaterias[index]!['profesor_id'][1]}"),
                      8.height,
                      Text("Aula: ${filteredMaterias[index]!['aula_id'][1]}"),
                      8.height,
                      Text(
                          "Horario: ${filteredMaterias[index]!['horario_id'][1]}"),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
