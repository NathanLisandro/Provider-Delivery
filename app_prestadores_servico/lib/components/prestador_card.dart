// lib/components/prestador_card.dart

import 'package:flutter/material.dart';
import '../models/prestador.dart';
import 'star_rating.dart';

class PrestadorCard extends StatelessWidget {
  final Prestador prestador;
  final VoidCallback onTap;

  const PrestadorCard({required this.prestador, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(prestador.nome),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Preço por hora: R\$${prestador.precoPorHora.toStringAsFixed(2)}'),
            Row(
              children: [
                StarRating(rating: prestador.avaliacaoMedia),
                SizedBox(width: 8),
                Text('(${prestador.quantidadeAvaliacoes})'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
