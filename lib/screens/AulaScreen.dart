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
  List<Map<String, dynamic>?> filteredAulas = [];
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

    aulas = await colegioService.getAulas();
    filteredAulas = aulas;

    setState(() {
      isLoading = false;
    });
  }

  void _filterAulas(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredAulas = aulas;
      });
    } else {
      setState(() {
        filteredAulas = aulas.where((aula) {
          final numero = aula?['numero']?.toLowerCase() ?? '';
          final name = aula?['name']?.toLowerCase() ?? '';

          return numero.contains(query.toLowerCase()) ||
              name.contains(query.toLowerCase());
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
        title: const Text('Aulas'),
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
              onChanged: _filterAulas,
            ),
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: filteredAulas.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: boxDecorationRoundedWithShadow(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Numero: ${filteredAulas[index]!['numero']}"),
                      8.height,
                      Text("Nombre: " + filteredAulas[index]!['name']),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
