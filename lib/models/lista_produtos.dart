import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import 'produto.dart';

import 'package:flutter/foundation.dart';

// Classe que representa uma lista de produtos e notifica os ouvintes quando há mudanças.
class ListaProdutos with ChangeNotifier {
  // Lista interna de produtos, inicializada com dados fictícios (DUMMY_PRODUTOS).
  final List<Produto> _itens = DUMMY_PRODUTOS;

  // Getter para obter uma cópia imutável da lista de produtos.
  List<Produto> get itens {
    return [..._itens];
  }

  // Getter para obter uma lista apenas dos produtos marcados como favoritos.
  List<Produto> get itensFavoritos {
    return _itens.where((prod) => prod.isFavorito).toList();
  }

  // Método para adicionar um novo produto à lista e notificar os ouvintes sobre a mudança.
  void addProduto(Produto produto) {
    _itens.add(produto);
    notifyListeners(); // Notifica os ouvintes (como widgets) sobre a mudança nos dados.
  }
}
