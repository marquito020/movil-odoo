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
  List<Map<String, dynamic>?> filteredCursos = [];
  ColegioService colegioService = ColegioService();
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    setState(() {
      isLoading = true;
    });

    cursos = await colegioService.getCursos();
    filteredCursos = cursos;

    setState(() {
      isLoading = false;
    });
  }

  void _filterCursos(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredCursos = cursos;
      });
    } else {
      setState(() {
        filteredCursos = cursos.where((curso) {
          final nivel = curso?['nivel']?.toLowerCase() ?? '';
          final grado = curso?['grado']?.toLowerCase() ?? '';
          final turno = curso?['turno']?.toLowerCase() ?? '';

          return nivel.contains(query.toLowerCase()) ||
              grado.contains(query.toLowerCase()) ||
              turno.contains(query.toLowerCase());
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
        title: const Text('Cursos'),
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
              onChanged: _filterCursos,
            ),
          ),
        ),
      ),
      drawer: DrawerWidget(),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: filteredCursos.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: boxDecorationRoundedWithShadow(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      8.height,
                      Text(
                        "Nivel: ${filteredCursos[index]!['nivel']}",
                      ),
                      8.height,
                      Text(
                        "Grado: ${filteredCursos[index]!['grado']}",
                      ),
                      8.height,
                      Text(
                        "Turno: ${filteredCursos[index]!['turno']}",
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
