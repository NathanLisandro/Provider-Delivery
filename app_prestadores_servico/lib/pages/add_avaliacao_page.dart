// lib/pages/add_avaliacao_page.dart

import 'package:flutter/material.dart';
import '../models/avaliacao.dart';
import '../services/api_service.dart';
import '../components/star_rating.dart';

class AddAvaliacaoPage extends StatefulWidget {
  final int prestadorId;

  const AddAvaliacaoPage({required this.prestadorId});

  @override
  _AddAvaliacaoPageState createState() => _AddAvaliacaoPageState();
}

class _AddAvaliacaoPageState extends State<AddAvaliacaoPage> {
  final _formKey = GlobalKey<FormState>();
  double nota = 5.0;
  String comentario = '';
  late ApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final avaliacao = Avaliacao(
        id: DateTime.now().millisecondsSinceEpoch,
        prestadorId: widget.prestadorId,
        nota: nota,
        comentario: comentario,
        data: DateTime.now(),
      );

      await apiService.addAvaliacao(avaliacao);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Avaliação adicionada com sucesso!')),
      );

      // Retorne true para indicar que a avaliação foi adicionada
      Navigator.pop(context, true);
    }
  }

  void _onRatingChanged(double newRating) {
    setState(() {
      nota = newRating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Avaliação'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text('Sua Avaliação:', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              StarRating(
                rating: nota,
                onRatingChanged: _onRatingChanged,
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Comentário'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um comentário';
                  }
                  return null;
                },
                onChanged: (value) {
                  comentario = value;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Enviar Avaliação'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
