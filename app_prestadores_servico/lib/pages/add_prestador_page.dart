import 'package:flutter/material.dart';
import '../models/prestador.dart';
import '../services/api_service.dart';

class AddPrestadorPage extends StatefulWidget {
  const AddPrestadorPage({Key? key}) : super(key: key);

  @override
  _AddPrestadorPageState createState() => _AddPrestadorPageState();
}

class _AddPrestadorPageState extends State<AddPrestadorPage> {
  final _formKey = GlobalKey<FormState>();
  String nome = '';
  String telefone = '';
  double precoPorHora = 0.0;
  String descricao = '';
  String complexidadeServico = 'Baixa';
  String servicosTexto = '';
  late ApiService apiService;

  final List<String> complexidades = ['Baixa', 'Média', 'Alta'];

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      List<String> servicos = servicosTexto.split(',').map((s) => s.trim()).toList();

      Prestador prestador = Prestador(
        id: DateTime.now().millisecondsSinceEpoch,
        nome: nome,
        telefone: telefone,
        precoPorHora: precoPorHora,
        avaliacaoMedia: 0.0,
        quantidadeAvaliacoes: 0,
        servicos: servicos,
        descricao: descricao,
        complexidadeServico: complexidadeServico,
      );

      await apiService.addPrestador(prestador);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Prestador adicionado com sucesso!')),
      );

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Prestador'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
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
                child: const Text('Adicionar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
