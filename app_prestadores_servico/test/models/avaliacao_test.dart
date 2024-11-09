import 'package:flutter_test/flutter_test.dart';
import 'package:app_prestadores_servico/models/avaliacao.dart';

void main() {
  group('Avaliacao Model', () {
    test('fromJson deve retornar um objeto Avaliacao válido', () {
      final json = {
        'id': 1,
        'prestadorId': 1,
        'nota': 5.0,
        'comentario': 'Excelente serviço!',
        'data': '2023-10-12T10:00:00Z',
      };

      final avaliacao = Avaliacao.fromJson(json);

      expect(avaliacao.id, 1);
      expect(avaliacao.prestadorId, 1);
      expect(avaliacao.nota, 5.0);
      expect(avaliacao.comentario, 'Excelente serviço!');
      expect(avaliacao.data, DateTime.parse('2023-10-12T10:00:00Z'));
    });

    test('toJson deve retornar um mapa JSON válido', () {
      final avaliacao = Avaliacao(
        id: 1,
        prestadorId: 1,
        nota: 5.0,
        comentario: 'Excelente serviço!',
        data: DateTime.parse('2023-10-12T10:00:00Z'),
      );

      final json = avaliacao.toJson();

      expect(json['id'], 1);
      expect(json['prestadorId'], 1);
      expect(json['nota'], 5.0);
      expect(json['comentario'], 'Excelente serviço!');
      expect(json['data'], '2023-10-12T10:00:00.000Z');
    });
  });
}
