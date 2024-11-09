import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_prestadores_servico/services/api_service.dart';
import 'package:app_prestadores_servico/models/prestador.dart';
import 'package:app_prestadores_servico/models/avaliacao.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late MockClient mockClient;
  late ApiService apiService;

  setUp(() {
    mockClient = MockClient();
    apiService = ApiService(client: mockClient);
  });

  group('ApiService', () {
    test('addPrestador deve adicionar um Prestador', () async {
      final prestador = Prestador(
        id: 3,
        nome: "Carlos Pereira",
        telefone: "999888777",
        avaliacaoMedia: 0,
        quantidadeAvaliacoes: 0,
        precoPorHora: 60,
        servicos: ["Pintor"],
        descricao: "Especialista em pintura residencial e comercial.",
        complexidadeServico: "Média",
      );

      when(() => mockClient.post(
            Uri.parse('http://localhost:3000/prestadores'),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => http.Response('', 201));

      await apiService.addPrestador(prestador);

      verify(() => mockClient.post(
            Uri.parse('http://localhost:3000/prestadores'),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).called(1);
    });

    test('getAvaliacoes deve retornar uma lista de Avaliacao', () async {
      final avaliacoesMock = [
        {
          "id": "1",
          "prestadorId": 1,
          "nota": 5,
          "comentario": "Excelente profissional!",
          "data": "2023-10-12T10:00:00Z"
        }
      ];

      when(() => mockClient
              .get(Uri.parse('http://localhost:3000/avaliacoes?prestadorId=1')))
          .thenAnswer(
              (_) async => http.Response(jsonEncode(avaliacoesMock), 200));

      final avaliacoes = await apiService.getAvaliacoes(1);

      expect(avaliacoes, isA<List<Avaliacao>>());
      expect(avaliacoes.length, 1);
      expect(avaliacoes.first.nota, 5);
    });
  });
}
