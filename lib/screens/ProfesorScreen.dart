import 'package:flutter/material.dart';
import 'package:movil_academico/services/colegio_service.dart';
import 'package:nb_utils/nb_utils.dart';

class ProfesorScreen extends StatefulWidget {
  const ProfesorScreen({super.key});

  @override
  State<ProfesorScreen> createState() => _ProfesorScreenState();
}

class _ProfesorScreenState extends State<ProfesorScreen> {
  List<Map<String, dynamic>?> profesores = [];
  List<Map<String, dynamic>?> filteredProfesores = [];
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

    profesores = await colegioService.getProfesores();
    filteredProfesores = profesores;

    setState(() {
      isLoading = false;
    });
  }

  void _filterProfesores(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredProfesores = profesores;
      });
    } else {
      setState(() {
        filteredProfesores = profesores.where((profesor) {
          final name = profesor?['name']?.toLowerCase() ?? '';

          return name.contains(query.toLowerCase());
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
        title: const Text('Profesores'),
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
              onChanged: _filterProfesores,
            ),
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: filteredProfesores.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: boxDecorationRoundedWithShadow(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nombre: ${filteredProfesores[index]!['name']}"),
                      8.height,
                    ],
                  ),
                );
              },
            ),
    );
  }
}
