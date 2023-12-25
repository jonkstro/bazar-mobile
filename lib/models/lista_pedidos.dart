import 'dart:math';

import 'package:bazar_do_bem/models/carrinho.dart';
import 'package:bazar_do_bem/models/pedido.dart';
import 'package:flutter/material.dart';

class ListaPedidos with ChangeNotifier {
  final List<Pedido> _itens = [];

  // Getter para obter uma cópia imutável da lista de pedidos.
  List<Pedido> get itens {
    return [..._itens];
  }

  // Getter para receber a contagem de itens
  int get qtdItens {
    return _itens.length;
  }

  // Método para adicionar um novo pedido à lista e notificar os ouvintes sobre a mudança.
  void addPedido(Carrinho cart) {
    // Sempre vai inserir na posição 0 [primeira] e mover o resto pra baixo
    _itens.insert(
      0,
      Pedido(
        id: Random().nextDouble().toString(),
        total: cart.valorTotal,
        // Vai adicionar no Pedido a lista de itens [carrinhoItem] que tem no carrinho
        produtos: cart.itens.values.toList(),
        data: DateTime.now(),
      ),
    );
    notifyListeners(); // Notifica os ouvintes (como widgets) sobre a mudança nos dados.
  }

  
}
