import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class HistorialMapasScreen extends StatelessWidget {
   
  const HistorialMapasScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const ScanTiles(tipo: 'geo');
  }
}
