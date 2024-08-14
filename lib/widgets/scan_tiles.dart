import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/utils/utils.dart';
import '../providers/providers.dart';
import '../theme/app_theme.dart';
import 'widgets.dart';

class ScanTiles extends StatelessWidget {
  final String tipo;
  const ScanTiles({super.key, required this.tipo});

  @override
  Widget build(BuildContext context) {
    // Obtener el provider para la lista de los scans
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    // Validar si hay registros ha mostrar
    if (scans.isEmpty) {
      return EmptyContainer(tipo: tipo);
    }

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, index) => Dismissible(
        key: UniqueKey(),
        background: Container(color: Colors.red),
        onDismissed: (direction) {
          // Borrar un registro especifico de la base de datos
          Provider.of<ScanListProvider>(context, listen: false).borrarScanPorId(scans[index].id!);
        },
        child: ListTile(
          leading: Icon(tipo == 'http' ? Icons.web : Icons.map, color: AppTheme.primary),
          title: Text(scans[index].valor),
          subtitle: Text('ID: ${scans[index].id}'),
          trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.grey),
          onTap: () => openUrl(context, scans[index]),
        ),
      ),
    );
  }
}