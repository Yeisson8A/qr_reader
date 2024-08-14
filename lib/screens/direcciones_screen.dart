import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class DireccionesScreen extends StatelessWidget {
   
  const DireccionesScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const ScanTiles(tipo: 'http');
  }
}