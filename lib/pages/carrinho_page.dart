import 'package:bazar_do_bem/components/carrinho_item_widget.dart';
import 'package:bazar_do_bem/models/carrinho.dart';
import 'package:bazar_do_bem/models/lista_pedidos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarrinhoPage extends StatelessWidget {
  // Construtor da classe CarrinhoPage recebendo a chave (key) como parâmetro opcional.
  const CarrinhoPage({super.key});

  @override
  Widget build(BuildContext context) {
    /// Obtém a instância do Carrinho usando o Provider.
    final Carrinho carrinho = Provider.of<Carrinho>(context);

    /// Converte os valores do mapping de itens do carrinho em uma lista.
    final itens = carrinho.itens.values.toList();

    // Estrutura principal da página.
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Carrinho'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          // Card exibindo o total do carrinho.
          Card(
            surfaceTintColor: Colors.white,
            margin: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 25,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 25,
              ),
              child: Row(
                children: <Widget>[
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(width: 10),

                  /// CHIP é o widget que vai fazer um "Container coloridinho"
                  /// Exibe o valor total do carrinho em um Chip.
                  Chip(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    label: Text(
                      'R\$${carrinho.valorTotal.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Botão para realizar a compra (ainda não implementado).
                  TextButton(
                    onPressed: () {
                      // Vai chamar o método de adicionar pedido do provider do ListaPedidos
                      Provider.of<ListaPedidos>(
                        context,
                        // Não pode ter listen igual a TRUE pois está fora do build!!!!!!
                        // se botar sem listen = FALSE vai dar Exception.
                        listen: false,
                      ).addPedido(carrinho);
                      // Limpar o carrinho após a compra.
                      carrinho.limpar();
                    },
                    child: const Text('COMPRAR'),
                  ),
                ],
              ),
            ),
          ),
          // Lista de itens no carrinho.
          Expanded(
            child: ListView.builder(
              itemCount: itens.length,
              itemBuilder: (context, index) {
                return CarrinhoItemWidget(
                    carrinhoItem:
                        itens[index]); // Ainda precisa ser implementado.
              },
            ),
          ),
        ],
      ),
    );
  }
}
