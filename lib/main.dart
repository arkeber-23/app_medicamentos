import 'package:farmacia/providers/medicine_provider.dart';
import 'package:farmacia/screens/home_screen.dart';
import 'package:farmacia/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MedicineProvider(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Gestión de Medicamentos',
          theme: Themes.light,
          home: const HomeScreen()),
    );
  }
}
