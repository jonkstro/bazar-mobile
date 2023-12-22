import 'dart:math';

import 'package:bazar_do_bem/models/carrinho_item.dart';
import 'package:bazar_do_bem/models/produto.dart';
import 'package:flutter/material.dart';

/// Classe Carrinho com ChangeNotifier para gerenciar o estado do carrinho de compras
class Carrinho with ChangeNotifier {
  /// Mapping para armazenar itens no carrinho, onde a chave é o ID do produto
  Map<String, CarrinhoItem> _itens = {};

  /// Getter para obter uma cópia imutável da lista de itens do carrinho.
  Map<String, CarrinhoItem> get itens {
    return {..._itens};
  }

  /// Getter para calcular e fornecer o total de itens no carrinho
  int get qtdItens {
    return _itens.length;
  }

  /// Getter para calcular e fornecer o valor total dos itens no carrinho
  double get valorTotal {
    double total = 0.0;

    /// Calcula o total iterando através de cada item no carrinho
    _itens.forEach((key, itemdoCarrinho) {
      total += itemdoCarrinho.preco * itemdoCarrinho.quantidade;
    });
    return total;
  }

  /// Método para adicionar um item ao carrinho
  void adicionarItem(Produto produto) {
    if (_itens.containsKey(produto.id)) {
      /// Se o item já estiver no carrinho, atualiza a quantidade
      _itens.update(
        produto.id,
        (itemExistente) => CarrinhoItem(
          id: itemExistente.id,
          idProduto: itemExistente.idProduto,
          nome: itemExistente.nome,
          // Adiciona mais 1 item na qtd
          quantidade: itemExistente.quantidade + 1,
          preco: itemExistente.preco,
        ),
      );
    } else {
      /// Se o item não estiver no carrinho, adiciona um novo ItemCarrinho
      _itens.putIfAbsent(
        produto.id,
        () => CarrinhoItem(
          id: Random().nextDouble().toString(),
          idProduto: produto.id,
          nome: produto.nome,
          quantidade: 1,
          preco: produto.preco,
        ),
      );
    }
    // Notifica os ouvintes que o carrinho foi atualizado
    notifyListeners();
  }

  /// Método para remover um item do carrinho com base no ID do produto
  void removerItem(String idProduto) {
    _itens.remove(idProduto);
    // Notifica os ouvintes que o carrinho foi atualizado
    notifyListeners();
  }

  /// Método para limpar todos os itens do carrinho
  void limpar() {
    _itens = {};
    // Notifica os ouvintes que o carrinho foi atualizado
    notifyListeners();
  }

  /// Método para obter a quantidade de um item específico no carrinho com base no ID do produto
  int getQuantidadeItem(String idProduto) {
    // Contem o idProduto? Se sim, boto a quantidade, senão, boto 0.
    // o ?? serve pra botar um valor caso nulo. Nesse caso se produto for nulo bota 0.
    return _itens.containsKey(idProduto) ? _itens[idProduto]?.quantidade ?? 0 : 0;
  }
}
