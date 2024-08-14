import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener el provider
    final uiProvider = Provider.of<UiProvider>(context);
    // Asignar indice actual almacenado en el provider
    final currentIndex = uiProvider.selectedMenuOpt;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (value) => uiProvider.selectedMenuOpt = value, // Asignar nuevo valor al indice del provider
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'Mapa'),
        BottomNavigationBarItem(icon: Icon(Icons.compass_calibration), label: 'Direcciones')
      ]
    );
  }
}