class Prestador {
  final int id;
  final String nome;
  final String telefone;
  double avaliacaoMedia;
  int quantidadeAvaliacoes;
  final double precoPorHora;
  final List<String> servicos;
  final String descricao;
  final String complexidadeServico;

  Prestador({
    required this.id,
    required this.nome,
    required this.telefone,
    required this.avaliacaoMedia,
    required this.quantidadeAvaliacoes,
    required this.precoPorHora,
    required this.servicos,
    required this.descricao,
    required this.complexidadeServico,
  });

  factory Prestador.fromJson(Map<String, dynamic> json) {
    return Prestador(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      nome: json['nome'],
      telefone: json['telefone'],
      avaliacaoMedia: (json['avaliacaoMedia'] as num).toDouble(),
      quantidadeAvaliacoes: json['quantidadeAvaliacoes'],
      precoPorHora: (json['precoPorHora'] as num).toDouble(),
      servicos: List<String>.from(json['servicos']),
      descricao: json['descricao'],
      complexidadeServico: json['complexidadeServico'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'telefone': telefone,
      'avaliacaoMedia': avaliacaoMedia,
      'quantidadeAvaliacoes': quantidadeAvaliacoes,
      'precoPorHora': precoPorHora,
      'servicos': servicos,
      'descricao': descricao,
      'complexidadeServico': complexidadeServico,
    };
  }
}
