import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/screens/screens.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        actions: [
          IconButton(
            onPressed: () {
              // Obtener el provider para la lista de los scans
              final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
              // Borrar todos los registros
              scanListProvider.borrarTodo();
            }, 
            icon: const Icon(Icons.delete_forever, color: Colors.white)
          )
        ]
      ),
      body: const _HomeScreenBody(),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener el provider que mantiene el indice seleccionado
    final uiProvider = Provider.of<UiProvider>(context);
    // Asignar indice actual almacenado en el provider
    final currentIndex = uiProvider.selectedMenuOpt;
    // Obtener el provider para la lista de los scans
    final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
    
    // Cambiar el índice para mostrar la pantalla respectiva
    switch (currentIndex) {
      case 0:
        // Cargar registros por tipo "geo"
        scanListProvider.cargarScansPorTipo('geo');
        return const HistorialMapasScreen();
      case 1:
        // Cargar registros por tipo "http"
        scanListProvider.cargarScansPorTipo('http');
        return const DireccionesScreen();
      default:
        return const HistorialMapasScreen();
    }
  }
}