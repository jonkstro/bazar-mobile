import 'package:bazar_do_bem/models/pedido.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PedidoWidget extends StatefulWidget {
  final Pedido pedido;
  const PedidoWidget({super.key, required this.pedido});

  @override
  State<PedidoWidget> createState() => _PedidoWidgetState();
}

class _PedidoWidgetState extends State<PedidoWidget> {
  bool _isExpandido = false;

  @override
  Widget build(BuildContext context) {
    // Tem que pegar do Widget, pois tá fora do build.
    // Só pra não ficar repetindo widget.pedido
    Pedido pedido = widget.pedido;
    return Card(
      surfaceTintColor: Colors.white,
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('R\$ ${pedido.total.toStringAsFixed(2)}'),
            subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(pedido.data),
            ),
            trailing: IconButton(
              // Se _isExpandido for falso o icone é expand_more, se for true é expand_less
              icon: !_isExpandido
                  ? const Icon(Icons.expand_more)
                  : const Icon(Icons.expand_less),
              // Ao clicar no botão, vai deixar expandido ou ocultado.
              onPressed: () {
                setState(() {
                  _isExpandido = !_isExpandido;
                });
              },
            ),
          ),

          /// SÓ VAI ABRIR SE _isExpandido FOR IGUAL A TRUE!!!!!!!!!!
          if (_isExpandido)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              // Vamos calcular mais ou menos a altura de cada linha como 24 e dar 10 de sobra
              height: (pedido.produtos.length * 24) + 10,
              child: ListView(
                // Por alguma razão misteriosa o children não pode ter [] senão dá pau
                children: pedido.produtos.map((produto) {
                  return Row(
                    children: <Widget>[
                      Text(
                        produto.nome,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${produto.quantidade}x R\$ ${produto.preco}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
