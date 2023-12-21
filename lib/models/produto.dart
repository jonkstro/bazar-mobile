import 'package:flutter/material.dart';

/// Vai adicionar Reatividade. Pois sempre que mudar o produto vai avisar os interessados
class Produto with ChangeNotifier {
  final String id;
  final String nome;
  final String descricao;
  final double preco;
  final String imagemUrl;
  bool isFavorito;

  Produto({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.preco,
    required this.imagemUrl,
    this.isFavorito = false,
  });
  /// Função que vai alternar o estado de favorito
  void mudarIsFavorito() {
    isFavorito = !isFavorito;
  }
}
