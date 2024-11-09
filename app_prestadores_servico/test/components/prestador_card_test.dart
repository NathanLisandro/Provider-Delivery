import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_prestadores_servico/components/prestador_card.dart';
import 'package:app_prestadores_servico/models/prestador.dart';
import 'package:app_prestadores_servico/components/star_rating.dart';

void main() {
  testWidgets('PrestadorCard exibe as informações do prestador', (WidgetTester tester) async {
    final prestador = Prestador(
      id: 1,
      nome: 'João Silva',
      telefone: '123456789',
      avaliacaoMedia: 4.5,
      quantidadeAvaliacoes: 2,
      precoPorHora: 50.0,
      servicos: ['Eletricista', 'Encanador'],
      descricao: 'Especialista em instalações elétricas',
      complexidadeServico: 'Alta',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PrestadorCard(
            prestador: prestador,
            onTap: () {},
          ),
        ),
      ),
    );

    expect(find.text('João Silva'), findsOneWidget);
    expect(find.text('Preço por hora: R\$50.00'), findsOneWidget);
    expect(find.byType(StarRating), findsOneWidget);
  });
}
