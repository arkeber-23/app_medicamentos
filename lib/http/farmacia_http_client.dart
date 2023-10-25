import 'dart:convert';
import 'package:farmacia/models/medicine.dart';
import 'package:dio/dio.dart';

class FarmaciaHttpClient {
  final String baseUrl = "url_backend";
  final dio = Dio();
  Future<List<Medicine>> getMedicines() async {
    try {
      final response = await dio.get('$baseUrl/farmacia');
      if (response.statusCode == 200) {
        return (json.decode(response.data) as List)
            .map((e) => Medicine.fromJson(e))
            .toList();
      } else {
        throw Exception('Error al obtener los medicamentos de Farmacia');
      }
    } catch (e) {
      throw Exception('Error al obtener los medicamentos de Farmacia $e');
    }
  }

  Future<String> create(Medicine medicine) async {
    try {
      final response =
          await dio.post('$baseUrl/farmacia/save', data: medicine.toJson());
      if (response.statusCode == 201) {
        return response.data.toString();
      }
      return 'Error al crear el medicamento de Farmacia';
    } catch (e) {
      throw Exception('Error al crear el medicamento de Farmacia $e');
    }
  }

  Future<String> update(Medicine medicine) async {
    try {
      final response =
          await dio.put('$baseUrl/farmacia/update', data: medicine.toJson());
      if (response.statusCode == 200) {
        return response.data.toString();
      }
      return 'Error al actualizar el medicamento de Farmacia';
    } catch (e) {
      throw Exception('Error al actualizar el medicamento de Farmacia $e');
    }
  }

  Future<String> delete(String id) async {
    try {
      final response =
          await dio.delete('$baseUrl/farmacia/delete', data: {'id': id});
      if (response.statusCode == 200) {
        return response.data.toString();
      }
      return 'Error al eliminar el medicamento de Farmacia';
    } catch (e) {
      throw Exception('Error al eliminar el medicamento de Farmacia $e');
    }
  }

  Future<List<Medicine>> getMedicineByName(String name) async {
    try {
      final response = await dio
          .get('$baseUrl/farmacia/findByName', queryParameters: {'name': name});
      if (response.statusCode == 200) {
        return (json.decode(response.data) as List)
            .map((e) => Medicine.fromJson(e))
            .toList();
      } else {
        return response.data;
      }
    } catch (e) {
      throw Exception('Error al obtener los medicamentos de Farmacia $e');
    }
  }
}
