// lib/pages/prestador_detail_page.dart

import 'package:flutter/material.dart';
import '../components/star_rating.dart';
import '../models/prestador.dart';
import '../models/avaliacao.dart';
import '../services/api_service.dart';
import 'chat_page.dart';
import 'add_avaliacao_page.dart';
import 'edit_prestador_page.dart';

class PrestadorDetailPage extends StatefulWidget {
  final Prestador prestador;

  const PrestadorDetailPage({required this.prestador});

  @override
  _PrestadorDetailPageState createState() => _PrestadorDetailPageState();
}

class _PrestadorDetailPageState extends State<PrestadorDetailPage> {
  late Prestador prestador;
  late Future<List<Avaliacao>> futureAvaliacoes;
  late ApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
    prestador = widget.prestador;
    futureAvaliacoes = apiService.getAvaliacoes(prestador.id);
  }

  void _navegarParaAdicionarAvaliacao() async {
    bool? avaliacaoAdicionada = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddAvaliacaoPage(
          prestadorId: prestador.id,
        ),
      ),
    );

    if (avaliacaoAdicionada == true) {
      // Atualize os dados do prestador
      await _atualizarPrestador();
      setState(() {
        futureAvaliacoes = apiService.getAvaliacoes(prestador.id);
      });
    }
  }

  Future<void> _atualizarPrestador() async {
    Prestador prestadorAtualizado = await apiService.getPrestadorById(prestador.id);
    setState(() {
      prestador = prestadorAtualizado;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Utilize o 'prestador' do estado
    return Scaffold(
      appBar: AppBar(
        title: Text(prestador.nome),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              bool? updated = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditPrestadorPage(prestador: prestador),
                ),
              );
              if (updated == true) {
                await _atualizarPrestador();
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              bool confirm = await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Confirmar Exclusão'),
                  content: Text('Você tem certeza que deseja excluir este prestador?'),
                  actions: [
                    TextButton(
                      child: Text('Cancelar'),
                      onPressed: () => Navigator.pop(context, false),
                    ),
                    TextButton(
                      child: Text('Excluir'),
                      onPressed: () => Navigator.pop(context, true),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                await apiService.deletePrestador(prestador.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Prestador removido com sucesso!')),
                );
                Navigator.pop(context, true); // Retorna true para indicar que o prestador foi removido
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(prestador.descricao, style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Telefone: ${prestador.telefone}'),
            Text('Preço por Hora: R\$${prestador.precoPorHora.toStringAsFixed(2)}'),
            Text('Complexidade: ${prestador.complexidadeServico}'),
            SizedBox(height: 10),
            Row(
              children: [
                StarRating(rating: prestador.avaliacaoMedia),
                SizedBox(width: 8),
                Text('(${prestador.quantidadeAvaliacoes})'),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Navegar para o chat mockado
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatPage()),
                );
              },
              child: Text('Solicitar Serviço'),
            ),
            ElevatedButton(
              onPressed: _navegarParaAdicionarAvaliacao,
              child: Text('Adicionar Avaliação'),
            ),
            SizedBox(height: 20),
            Text('Avaliações',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            FutureBuilder<List<Avaliacao>>(
              future: futureAvaliacoes,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Avaliacao> avaliacoes = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: avaliacoes.length,
                    itemBuilder: (context, index) {
                      Avaliacao avaliacao = avaliacoes[index];
                      return ListTile(
                        title: StarRating(rating: avaliacao.nota),
                        subtitle: Text(avaliacao.comentario),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                }

                return Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }
}
