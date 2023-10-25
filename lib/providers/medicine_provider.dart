import 'package:farmacia/http/farmacia_http_client.dart';
import 'package:farmacia/models/medicine.dart';
import 'package:flutter/material.dart';

class MedicineProvider extends ChangeNotifier {
  List<Medicine> _medicines = [];
  String _message = '';
  bool _initialLoading = true;

  bool get initialLoading => _initialLoading;
  String get message => _message;
  List<Medicine> get medicines => _medicines;

  MedicineProvider() {
    getMedicines();
  }

  Future<void> getMedicines() async {
    _medicines = await FarmaciaHttpClient().getMedicines();
    _initialLoading = false;
    notifyListeners();
  }

  Future<void> addMedicine(Medicine? medicine) async {
    _initialLoading = true;
    _message = medicine == null
        ? 'Debe seleccionar un medicamento'
        : await FarmaciaHttpClient().create(medicine);
    await getMedicines();
  }

  Future<void> updateMedicine(Medicine? medicine) async {
    _initialLoading = true;
    _message = medicine == null
        ? 'Debe seleccionar un medicamento'
        : await FarmaciaHttpClient().update(medicine);
    await getMedicines();
  }

  Future<void> deleteMedicine(String id) async {
    _initialLoading = true;
    _message = await FarmaciaHttpClient().delete(id);
    await getMedicines();
  }

  Future<void> searchMedicineByName(String? name) async {
    _initialLoading = true;
    if (name != null) {
      _medicines = await FarmaciaHttpClient().getMedicineByName(name);
      return;
    }
    _medicines = await FarmaciaHttpClient().getMedicines();
    _initialLoading = false;
    notifyListeners();
  }
}
