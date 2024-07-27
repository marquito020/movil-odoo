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
  List<Map<String, dynamic>?> filteredHorarios = [];
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

    horarios = await colegioService.getHorarios();
    filteredHorarios = horarios;

    setState(() {
      isLoading = false;
    });
  }

  void _filterHorarios(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredHorarios = horarios;
      });
    } else {
      setState(() {
        filteredHorarios = horarios.where((horario) {
          final name = horario?['name']?.toLowerCase() ?? '';
          final horaInicio = horario?['hora_inicio']?.toLowerCase() ?? '';
          final horaFin = horario?['hora_fin']?.toLowerCase() ?? '';

          return name.contains(query.toLowerCase()) ||
              horaInicio.contains(query.toLowerCase()) ||
              horaFin.contains(query.toLowerCase());
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
        title: const Text('Horarios'),
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
              onChanged: _filterHorarios,
            ),
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: filteredHorarios.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: boxDecorationRoundedWithShadow(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nombre: ${filteredHorarios[index]!['name']}"),
                      8.height,
                      Text(
                          "Hora Inicio: ${filteredHorarios[index]!['hora_inicio']}"),
                      8.height,
                      Text("Hora Fin: ${filteredHorarios[index]!['hora_fin']}"),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
