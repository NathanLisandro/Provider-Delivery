import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/prestador.dart';
import '../models/avaliacao.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:3000';
  final http.Client client;

  ApiService({http.Client? client}) : client = client ?? http.Client();

  Future<List<Prestador>> getPrestadores() async {
    final response = await client.get(Uri.parse('$baseUrl/prestadores'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      return jsonResponse.map((prestador) => Prestador.fromJson(prestador)).toList();
    } else {
      throw Exception('Falha ao carregar prestadores');
    }
  }

  Future<Prestador> getPrestadorById(int id) async {
    final response = await client.get(Uri.parse('$baseUrl/prestadores/$id'));

    if (response.statusCode == 200) {
      return Prestador.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Falha ao carregar prestador');
    }
  }

  Future<void> addPrestador(Prestador prestador) async {
    final response = await client.post(
      Uri.parse('$baseUrl/prestadores'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(prestador.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Falha ao adicionar prestador');
    }
  }

  Future<void> updatePrestador(Prestador prestador) async {
    final response = await client.put(
      Uri.parse('$baseUrl/prestadores/${prestador.id}'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(prestador.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao atualizar prestador');
    }
  }

  Future<void> deletePrestador(int id) async {
    final response = await client.delete(Uri.parse('$baseUrl/prestadores/$id'));

    if (response.statusCode != 200) {
      throw Exception('Falha ao remover prestador');
    }
  }

  Future<List<Avaliacao>> getAvaliacoes(int prestadorId) async {
    final response =
        await client.get(Uri.parse('$baseUrl/avaliacoes?prestadorId=$prestadorId'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      return jsonResponse.map((avaliacao) => Avaliacao.fromJson(avaliacao)).toList();
    } else {
      throw Exception('Falha ao carregar avaliações');
    }
  }

  Future<void> addAvaliacao(Avaliacao avaliacao) async {
    final response = await client.post(
      Uri.parse('$baseUrl/avaliacoes'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(avaliacao.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Falha ao adicionar avaliação');
    }

    await updateAvaliacaoMedia(avaliacao.prestadorId);
  }

  Future<void> updateAvaliacaoMedia(int prestadorId) async {
    List<Avaliacao> avaliacoes = await getAvaliacoes(prestadorId);
    double totalPontuacao = avaliacoes.fold(0.0, (soma, item) => soma + item.nota);
    int quantidadeDeAvaliacoes = avaliacoes.length;
    double media =
        quantidadeDeAvaliacoes > 0 ? totalPontuacao / quantidadeDeAvaliacoes : 0.0;
    Prestador prestador = await getPrestadorById(prestadorId);
    prestador.avaliacaoMedia = media;
    prestador.quantidadeAvaliacoes = quantidadeDeAvaliacoes;

    await updatePrestador(prestador);
  }

  Future<void> deleteAvaliacao(int id) async {
    final response = await client.delete(Uri.parse('$baseUrl/avaliacoes/$id'));

    if (response.statusCode != 200) {
      throw Exception('Falha ao remover avaliação');
    }
  }
}
