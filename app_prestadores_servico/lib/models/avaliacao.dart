class Avaliacao {
  final int id;
  final int prestadorId;
  final double nota;
  final String comentario;
  final DateTime data;

  Avaliacao({
    required this.id,
    required this.prestadorId,
    required this.nota,
    required this.comentario,
    required this.data,
  });

  factory Avaliacao.fromJson(Map<String, dynamic> json) {
    return Avaliacao(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      prestadorId: json['prestadorId'] is int
          ? json['prestadorId']
          : int.parse(json['prestadorId'].toString()),
      nota: (json['nota'] as num).toDouble(),
      comentario: json['comentario'] ?? '',
      data: DateTime.parse(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'prestadorId': prestadorId,
      'nota': nota,
      'comentario': comentario,
      'data': data.toIso8601String(),
    };
  }
}
