import 'package:bazar_do_bem/models/carrinho_item.dart';

class Pedido {
  final String id;
  final double total;
  // Vai receber os produtos do Carrinho [carrinhoItem] quando apertar em "comprar"
  final List<CarrinhoItem> produtos;
  // Vai receber a data que foi feito a compra
  final DateTime data;

  Pedido({
    required this.id,
    required this.total,
    required this.produtos,
    required this.data,
  });
}
