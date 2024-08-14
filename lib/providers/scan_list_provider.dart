import 'package:flutter/material.dart';
import '../models/scan_model.dart';
import 'db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  Future<ScanModel> nuevoScan(String valor) async {
    // Crear instancia con valor leido
    final nuevoScan = ScanModel(tipo: tipoSeleccionado, valor: valor);
    // Insertar registro en la base de datos
    final id = await DBProvider.db.nuevoScan(nuevoScan);
    // Asignar el id de la base de datos al modelo
    nuevoScan.id = id;
    
    // Validar que el tipo del nuevo scan corresponda al tipo seleccionado, a fin de agregar a listado y redibujar
    if (tipoSeleccionado == nuevoScan.tipo) {
      // Agregar nuevo scan creado a listado de scans
      scans.add(nuevoScan);
      // Notificar a los widgets que la información ha cambiado y debe redibujar
      notifyListeners();
    }
    return nuevoScan;
  }

  cargarScans() async {
    // Obtener registros de la base de datos
    final scans = await DBProvider.db.getAllScans();
    // Crear una nueva lista con base en los resultados obtenidos
    this.scans = [...scans];
    // Notificar a los widgets que la información ha cambiado y debe redibujar
    notifyListeners();
  }

  cargarScansPorTipo(String tipo) async {
    // Obtener registros de la base de datos
    final scans = await DBProvider.db.getScansPorTipo(tipo);
    // Crear una nueva lista con base en los resultados obtenidos
    this.scans = [...scans];
    // Asignar como tipo seleccionado el valor recibido como parámetro
    tipoSeleccionado = tipo;
    // Notificar a los widgets que la información ha cambiado y debe redibujar
    notifyListeners();
  }

  borrarTodo() async {
    // Borrar todos los registros de la base de datos
    await DBProvider.db.deleteAllScans();
    // Reinicializar lista de scans
    scans = [];
    // Notificar a los widgets que la información ha cambiado y debe redibujar
    notifyListeners();
  }

  borrarScanPorId(int id) async {
    // Borrar scan especifico de la base de datos
    await DBProvider.db.deleteScan(id);
  }
}