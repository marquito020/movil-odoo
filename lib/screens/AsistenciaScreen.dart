import 'package:flutter/material.dart';
import 'package:movil_academico/services/colegio_service.dart';

class AsistenciaScreen extends StatefulWidget {
  const AsistenciaScreen({super.key});

  @override
  State<AsistenciaScreen> createState() => _AsistenciaScreenState();
}

class _AsistenciaScreenState extends State<AsistenciaScreen> {
  List<Map<String, dynamic>?> asistencias = [];
  List<Map<String, dynamic>?> filteredAsistencias = [];
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

    asistencias = await colegioService.getAsistencias();
    filteredAsistencias = asistencias;

    setState(() {
      isLoading = false;
    });
  }

  void _filterAsistencias(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredAsistencias = asistencias;
      });
    } else {
      setState(() {
        filteredAsistencias = asistencias.where((asistencia) {
          final alumno = asistencia?['alumno_id']?[1]?.toLowerCase() ?? '';
          final profesor = asistencia?['profesor_id']?[1]?.toLowerCase() ?? '';
          final fecha = asistencia?['fecha']?.toLowerCase() ?? '';

          return alumno.contains(query.toLowerCase()) ||
              profesor.contains(query.toLowerCase()) ||
              fecha.contains(query.toLowerCase());
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
        title: const Text('Asistencias'),
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
              onChanged: _filterAsistencias,
            ),
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: filteredAsistencias.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text("Alumno:" +
                        filteredAsistencias[index]?['alumno_id'][1]),
                    subtitle: Text(
                        filteredAsistencias[index]?['profesor_id'][1] ?? ''),
                    /* trailing: Text(filteredAsistencias[index]?['fecha'] ?? ''), */
                  ),
                );
              },
            ),
    );
  }
}
