import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/scan_model.dart';

Future<void> openUrl(BuildContext context, ScanModel scan) async {
  final url = scan.valor;

  // Validar el tipo de scan
  if (scan.tipo == 'http') {
    // Abrir el sitio web
    if (!await launchUrl(Uri.parse(url), mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }
  else {
    // Navegar a la pantalla que visualiza el mapa
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }
}