import 'package:farmacia/models/medicine.dart';
import 'package:farmacia/providers/medicine_provider.dart';
import 'package:farmacia/widgets/list_medicine.dart';
import 'package:farmacia/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final medicineProvider = context.watch<MedicineProvider>();
    final medicineProviderRead = context.read<MedicineProvider>();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Gestor de Medicamentos',
            style: TextStyle(color: Themes.lightPrimary),
          ),
          backgroundColor: Themes.primary,
          actions: [
            IconButton(
              onPressed: () {
                medicineProviderRead.searchMedicineByName("Carlos");
                /* showSearch(
                context: context,
                delegate: medicineProviderRead.searchMedicineByName('p')(
                  medicines: medicineProvider.medicines,
                ),
              ); */
              },
              icon: Icon(Icons.search, color: Themes.lightPrimary),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
                tooltip: 'Añadir Medicamento',
                onPressed: () {
                  addMedicine(context);
                },
                icon: Icon(
                  Icons.add,
                  size: 30,
                  color: Themes.lightPrimary,
                ))
          ],
        ),
        body: Column(children: [
          Expanded(
            child: medicineProvider.initialLoading
                ? const Center(child: CircularProgressIndicator())
                : ListMedicine(medicines: medicineProvider.medicines),
          )
        ]));
  }

  Future<void> addMedicine(BuildContext context) {
    final TextEditingController medicamentoController = TextEditingController();
    final TextEditingController fechaController = TextEditingController();
    final medicineProviderRead = context.read<MedicineProvider>();
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'AGREGAR MEDICAMENTO',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: medicamentoController,
              decoration: const InputDecoration(
                labelText: 'Nombre Medicamento',
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: fechaController,
              decoration: const InputDecoration(
                labelText: 'Fecha',
                hintText: 'yyyy/MM/dd',
              ),
              onTap: () async {
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2050),
                );

                if (selectedDate != null) {
                  fechaController.text =
                      DateFormat('yyyy/MM/dd').format(selectedDate);
                }
              },
            )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (medicamentoController.text.isEmpty ||
                  fechaController.text.isEmpty) {
                _showToast(context, 'Los campos son obligatorios');
                return;
              }

              medicineProviderRead.addMedicine(Medicine(
                  name: medicamentoController.text,
                  endDate: fechaController.text));
              Navigator.pop(context);
              _showToast(context, medicineProviderRead.message.toString());
            },
            child: Text(
              'Aceptar',
              style: TextStyle(color: Colors.blue[700]),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancelar',
              style: TextStyle(color: Colors.red[700]),
            ),
          ),
        ],
      ),
    );
  }

  void _showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: Themes.primary,
        content: Text(
          message,
          style: TextStyle(fontSize: 20, color: Themes.lightPrimary),
        )));
  }
}
