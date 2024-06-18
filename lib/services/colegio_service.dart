import 'dart:convert';

import '../config/dio_config.dart';

class ColegioService {
  Future<List<Map<String, dynamic>?>> getCursos() async {
    final fields = ["id", "name", "nivel", "grado", "turno"];
    final response = await DioConfig.dioWithoutAuthorization.get(
      '/send_request?model=mi_modulo_academico.curso',
      data: {
        'fields': fields,
      },
    );

    if (response.statusCode == 200) {
      // Ensure response.data is decoded correctly
      final data = json.decode(response.data);

      if (data is Map &&
          data.containsKey("records") &&
          data["records"] is List) {
        final records = data["records"] as List;
        // Ensure the list contains maps
        return records
            .map((record) => record as Map<String, dynamic>?)
            .toList();
      } else {
        // Handle case where "records" key is missing or is not a List
        print(
            "Error: 'records' key is missing or not a List in response data.");
        return [];
      }
    } else {
      // Handle non-200 status code
      print("Error: Request failed with status: ${response.statusCode}");
      return [];
    }
  }

  Future<List<Map<String, dynamic>?>> getAulas() async {
    final fields = ["id", "numero", "name"];
    final response = await DioConfig.dioWithoutAuthorization.get(
      '/send_request?model=mi_modulo_academico.aula',
      data: {
        'fields': fields,
      },
    );

    if (response.statusCode == 200) {
      // Ensure response.data is decoded correctly
      final data = json.decode(response.data);

      if (data is Map &&
          data.containsKey("records") &&
          data["records"] is List) {
        final records = data["records"] as List;
        // Ensure the list contains maps
        return records
            .map((record) => record as Map<String, dynamic>?)
            .toList();
      } else {
        // Handle case where "records" key is missing or is not a List
        print(
            "Error: 'records' key is missing or not a List in response data.");
        return [];
      }
    } else {
      // Handle non-200 status code
      print("Error: Request failed with status: ${response.statusCode}");
      return [];
    }
  }

  Future<List<Map<String, dynamic>?>> getHorarios() async {
    final fields = ["id", "name", "hora_inicio", "hora_fin"];
    final response = await DioConfig.dioWithoutAuthorization.get(
      '/send_request?model=mi_modulo_academico.horario',
      data: {
        'fields': fields,
      },
    );

    if (response.statusCode == 200) {
      // Ensure response.data is decoded correctly
      final data = json.decode(response.data);

      if (data is Map &&
          data.containsKey("records") &&
          data["records"] is List) {
        final records = data["records"] as List;
        // Ensure the list contains maps
        return records
            .map((record) => record as Map<String, dynamic>?)
            .toList();
      } else {
        // Handle case where "records" key is missing or is not a List
        print(
            "Error: 'records' key is missing or not a List in response data.");
        return [];
      }
    } else {
      // Handle non-200 status code
      print("Error: Request failed with status: ${response.statusCode}");
      return [];
    }
  }

  Future<List<Map<String, dynamic>?>> getProfesores() async {
    final fields = ["id", "name"];
    final response = await DioConfig.dioWithoutAuthorization.get(
      '/send_request?model=mi_modulo_academico.profesor',
      data: {
        'fields': fields,
      },
    );

    if (response.statusCode == 200) {
      // Ensure response.data is decoded correctly
      final data = json.decode(response.data);

      if (data is Map &&
          data.containsKey("records") &&
          data["records"] is List) {
        final records = data["records"] as List;
        // Ensure the list contains maps
        return records
            .map((record) => record as Map<String, dynamic>?)
            .toList();
      } else {
        // Handle case where "records" key is missing or is not a List
        print(
            "Error: 'records' key is missing or not a List in response data.");
        return [];
      }
    } else {
      // Handle non-200 status code
      print("Error: Request failed with status: ${response.statusCode}");
      return [];
    }
  }

  Future<List<Map<String, dynamic>?>> getMaterias() async {
    final fields = ["id", "curso_id", "profesor_id", "aula_id", "horario_id", "name"];
    final response = await DioConfig.dioWithoutAuthorization.get(
      '/send_request?model=mi_modulo_academico.materia',
      data: {
        'fields': fields,
      },
    );

    if (response.statusCode == 200) {
      // Ensure response.data is decoded correctly
      final data = json.decode(response.data);

      if (data is Map &&
          data.containsKey("records") &&
          data["records"] is List) {
        final records = data["records"] as List;
        // Ensure the list contains maps
        return records
            .map((record) => record as Map<String, dynamic>?)
            .toList();
      } else {
        // Handle case where "records" key is missing or is not a List
        print(
            "Error: 'records' key is missing or not a List in response data.");
        return [];
      }
    } else {
      // Handle non-200 status code
      print("Error: Request failed with status: ${response.statusCode}");
      return [];
    }
  }
}
