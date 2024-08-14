import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/utils/utils.dart';
import '../providers/providers.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.filter_center_focus, color: Colors.white),
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#009688', 'Cancelar', false, ScanMode.QR);
        // Validar si el usuario cancelo el scan
        if (barcodeScanRes == '-1') return;
        // Obtener el provider para la lista de los scans
        final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
        // Insertar nuevo registro
        final nuevoScan = await scanListProvider.nuevoScan(barcodeScanRes);
        // Abrir url o mapa del scan
        openUrl(context, nuevoScan);
      },
    );
  }
}