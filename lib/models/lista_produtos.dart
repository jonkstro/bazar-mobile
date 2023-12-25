import 'dart:math';

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

  // Getter para receber a contagem de itens
  int get qtdItens {
    return _itens.length;
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

  /// CRUD - INÍCIO
  // Método que vai criar um novo produto, é possível customizar para salvar em BD depois
  // vai ser passado como parâmetro os dados enviados pela página de Formulário.
  void createProduto(Map<String, Object> dados) {
    // verificar se já tem algum id no produto passado, se já tiver um id, vai atualizar
    // ao invés de adicionar novo produto na memória/BD
    bool hasId = dados['id'] != null;

    final produto = Produto(
      // Tem ID? Se sim vai receber o mesmo ID, senão vai ser gerado um novo aleatório
      id: hasId ? dados['id'].toString() : Random().nextDouble().toString(),
      nome: dados['nome'].toString(),
      descricao: dados['descricao'].toString(),
      preco: double.parse(dados['preco'].toString()),
      imagemUrl: dados['imagemUrl'].toString(),
    );

    // Tem ID? Se sim, vai chamar o update, senão vai criar um novo produto
    hasId ? updateProduto(produto) : addProduto(produto);

    /// OBS.: NÃO VAI PRECISAR NOTIFICAR COM NOTIFY LISTENERS POIS JÁ TEM NO UPDATE E ADDPRODUTO
  }

  // Método que vai atualizar os dados de um produto já existente.
  void updateProduto(Produto produto) {
    // Se não achar o indice o indexWhere retorna index = -1, se achar retorna o indice
    int index = _itens.indexWhere((element) => element.id == produto.id);
    if (index >= 0) {
      // Se indice achado for > -1 então achou, esse item então vai receber o produto recebido
      _itens[index] = produto;
      notifyListeners(); // Notifica os ouvintes (como widgets) sobre a mudança nos dados.
    }
  }

  void deleteProduto(Produto produto) {
    // Se não achar o indice o indexWhere retorna index = -1, se achar retorna o indice
    int index = _itens.indexWhere((element) => element.id == produto.id);
    if (index >= 0) {
      // Se indice achado for > -1 então achou, logo removerá o product
      _itens.removeWhere((element) => element.id == produto.id);
    }
    notifyListeners(); // Notifica os ouvintes (como widgets) sobre a mudança nos dados.
  }

  /// CRUD - FIM
}
