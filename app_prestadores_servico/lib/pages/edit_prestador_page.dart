import 'package:flutter/material.dart';
import '../models/prestador.dart';
import '../services/api_service.dart';

class EditPrestadorPage extends StatefulWidget {
  final Prestador prestador;

  const EditPrestadorPage({required this.prestador});

  @override
  _EditPrestadorPageState createState() => _EditPrestadorPageState();
}

class _EditPrestadorPageState extends State<EditPrestadorPage> {
  final _formKey = GlobalKey<FormState>();
  late String nome;
  late String telefone;
  late double precoPorHora;
  late String descricao;
  late String complexidadeServico;
  late String servicosTexto;
  late ApiService apiService;

  final List<String> complexidades = ['Baixa', 'Média', 'Alta'];

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
    nome = widget.prestador.nome;
    telefone = widget.prestador.telefone;
    precoPorHora = widget.prestador.precoPorHora;
    descricao = widget.prestador.descricao;
    complexidadeServico = widget.prestador.complexidadeServico;
    servicosTexto = widget.prestador.servicos.join(', ');
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      List<String> servicos = servicosTexto.split(',').map((s) => s.trim()).toList();

      Prestador prestadorAtualizado = Prestador(
        id: widget.prestador.id,
        nome: nome,
        telefone: telefone,
        precoPorHora: precoPorHora,
        avaliacaoMedia: widget.prestador.avaliacaoMedia,
        quantidadeAvaliacoes: widget.prestador.quantidadeAvaliacoes,
        servicos: servicos,
        descricao: descricao,
        complexidadeServico: complexidadeServico,
      );

      await apiService.updatePrestador(prestadorAtualizado);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Prestador atualizado com sucesso!')),
      );

      Navigator.pop(context, true); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Prestador'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: nome,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
                onChanged: (value) => setState(() => nome = value),
              ),
              TextFormField(
                initialValue: telefone,
                decoration: const InputDecoration(labelText: 'Telefone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o telefone';
                  }
                  return null;
                },
                onChanged: (value) => setState(() => telefone = value),
              ),
              TextFormField(
                initialValue: precoPorHora.toString(),
                decoration: const InputDecoration(labelText: 'Preço por Hora'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || double.tryParse(value) == null) {
                    return 'Por favor, insira um preço válido';
                  }
                  return null;
                },
                onChanged: (value) => setState(() => precoPorHora = double.parse(value)),
              ),
              TextFormField(
                initialValue: descricao,
                decoration: const InputDecoration(labelText: 'Descrição do Serviço'),
                maxLines: 3,
                onChanged: (value) => setState(() => descricao = value),
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(labelText: 'Complexidade do Serviço'),
                value: complexidadeServico,
                items: complexidades.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) => setState(() => complexidadeServico = newValue!),
              ),
              TextFormField(
                initialValue: servicosTexto,
                decoration:
                    const InputDecoration(labelText: 'Serviços (separados por vírgula)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira pelo menos um serviço';
                  }
                  return null;
                },
                onChanged: (value) => setState(() => servicosTexto = value),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Salvar Alterações'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
