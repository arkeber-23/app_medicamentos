import 'package:farmacia/models/medicine.dart';
import 'package:farmacia/providers/medicine_provider.dart';
import 'package:farmacia/widgets/custom_button.dart';
import 'package:farmacia/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ListMedicine extends StatelessWidget {
  final List<Medicine> medicines;
  const ListMedicine({Key? key, required this.medicines}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final medicineProviderRead = context.read<MedicineProvider>();
    final TextEditingController medicamentoController = TextEditingController();
    final TextEditingController fechaController = TextEditingController();
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: medicines.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Themes.primary,
                  child: Text(
                    medicines[index].name.substring(0, 2),
                    style: TextStyle(color: Themes.lightPrimary),
                  ),
                ),
                title: Text(medicines[index].name),
                subtitle: Text("Exp: ${medicines[index].endDate} "),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  CustomButton(
                    icon: Icons.edit,
                    color: Themes.blue,
                    onPressed: () {
                      medicamentoController.text = medicines[index].name;
                      fechaController.text = medicines[index].endDate;
                      return _editMedicine(context, medicamentoController,
                          fechaController, medicineProviderRead, index);
                    },
                  ),
                  CustomButton(
                    icon: Icons.delete,
                    color: Themes.red,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Center(
                              child: Text(
                                '¿Desea eliminar este medicamento?',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            content: const Text(
                              'Esta acción es irreversible...',
                              style: TextStyle(fontSize: 16),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  medicineProviderRead.deleteMedicine(
                                    medicines[index].id.toString(),
                                  );
                                  _showToast(context,
                                      medicineProviderRead.message.toString());
                                },
                                child: Text(
                                  'Si, Confirmar',
                                  style: TextStyle(color: Themes.blue),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'No, Cancelar',
                                  style: TextStyle(color: Themes.red),
                                ),
                              )
                            ],
                          );
                        },
                      );
                    },
                  ),
                ]),
              );
            },
            separatorBuilder: (_, __) => const Divider(),
          ),
        ),
      ],
    );
  }

  Future<dynamic> _editMedicine(
      BuildContext context,
      TextEditingController medicamentoController,
      TextEditingController fechaController,
      MedicineProvider medicineProviderRead,
      int index) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'ACTUALIZAR MEDICAMENTO',
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

              medicineProviderRead.updateMedicine(Medicine(
                  id: medicines[index].id,
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
