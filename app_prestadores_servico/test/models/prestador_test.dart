import 'package:flutter_test/flutter_test.dart';
import 'package:app_prestadores_servico/models/prestador.dart';

void main() {
  group('Prestador Model', () {
    test('fromJson deve retornar um objeto Prestador válido', () {
      final json = {
        'id': 1,
        'nome': 'João Silva',
        'telefone': '123456789',
        'avaliacaoMedia': 4.5,
        'quantidadeAvaliacoes': 2,
        'precoPorHora': 50.0,
        'servicos': ['Eletricista', 'Encanador'],
        'descricao': 'Especialista em instalações elétricas',
        'complexidadeServico': 'Alta',
      };

      final prestador = Prestador.fromJson(json);

      expect(prestador.id, 1);
      expect(prestador.nome, 'João Silva');
      expect(prestador.telefone, '123456789');
      expect(prestador.avaliacaoMedia, 4.5);
      expect(prestador.quantidadeAvaliacoes, 2);
      expect(prestador.precoPorHora, 50.0);
      expect(prestador.servicos, ['Eletricista', 'Encanador']);
      expect(prestador.descricao, 'Especialista em instalações elétricas');
      expect(prestador.complexidadeServico, 'Alta');
    });

    test('toJson deve retornar um mapa JSON válido', () {
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

      final json = prestador.toJson();

      expect(json['id'], 1);
      expect(json['nome'], 'João Silva');
      expect(json['telefone'], '123456789');
      expect(json['avaliacaoMedia'], 4.5);
      expect(json['quantidadeAvaliacoes'], 2);
      expect(json['precoPorHora'], 50.0);
      expect(json['servicos'], ['Eletricista', 'Encanador']);
      expect(json['descricao'], 'Especialista em instalações elétricas');
      expect(json['complexidadeServico'], 'Alta');
    });
  });
}
