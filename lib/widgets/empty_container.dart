import 'package:flutter/material.dart';

class EmptyContainer extends StatelessWidget {
  final String tipo;
  const EmptyContainer({super.key, required this.tipo});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(tipo == 'http' ? Icons.web : Icons.map, color: Colors.black38, size: 130),
            const Text('Sin registros para mostrar', style: TextStyle(fontSize: 23, color: Colors.black38))
          ],
        ),
      )
    );
  }
}