import 'package:bazar_do_bem/components/app_drawer.dart';
import 'package:bazar_do_bem/components/pedido_widget.dart';
import 'package:bazar_do_bem/models/lista_pedidos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PedidosPage extends StatelessWidget {
  const PedidosPage({super.key});

  @override
  Widget build(BuildContext context) {
    /// Obtém a instância do Pedido usando o Provider.
    final ListaPedidos pedidos = Provider.of<ListaPedidos>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,

      /// Criar uma ListView com os itens [List<Pedido>] de ListaPedidos.
      body: ListView.builder(
        itemCount: pedidos.itens.length,
        itemBuilder: (ctx, index) {
          return PedidoWidget(pedido: pedidos.itens[index]);
        },
      ),
      drawer: const AppDrawer(),
    );
  }
}
