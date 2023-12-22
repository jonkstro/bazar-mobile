import 'package:bazar_do_bem/models/carrinho.dart';
import 'package:bazar_do_bem/models/carrinho_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarrinhoItemWidget extends StatelessWidget {
  // O construtor recebe um objeto CarrinhoItem obrigatório.
  final CarrinhoItem carrinhoItem;
  const CarrinhoItemWidget({super.key, required this.carrinhoItem});

  @override
  Widget build(BuildContext context) {
    // Widget Dismissible para permitir o gesto de arrastar para excluir.
    return Dismissible(
      key: ValueKey(carrinhoItem.id),
      direction: DismissDirection.endToStart,
      // Fundo vermelho ao arrastar para excluir.
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      // Callback chamado quando o item é arrastado para ser removido.
      onDismissed: (_) {
        // Remove o item do carrinho usando o Provider.
        Provider.of<Carrinho>(
          context,
          listen: false,
        ).removerItem(carrinhoItem.idProduto);
      },
      // Conteúdo principal do widget.
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          // ListTile exibindo detalhes do item no carrinho.
          child: ListTile(
            // Avatar circular exibindo o preço do produto.
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FittedBox(
                  child: Text('${carrinhoItem.preco}'),
                ),
              ),
            ),
            // Nome do produto.
            title: Text(carrinhoItem.nome),
            // Subtítulo exibindo o total do item no carrinho.
            subtitle: Text(
                'Total: R\$ ${(carrinhoItem.preco * carrinhoItem.quantidade).toStringAsFixed(2)}'),
            // Quantidade do produto.
            trailing: Text('${carrinhoItem.quantidade}x'),
          ),
        ),
      ),
    );
  }
}
