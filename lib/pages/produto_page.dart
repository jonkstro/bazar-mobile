import 'package:bazar_do_bem/components/app_drawer.dart';
import 'package:bazar_do_bem/components/produto_widget.dart';
import 'package:bazar_do_bem/models/lista_produtos.dart';
import 'package:bazar_do_bem/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProdutoPage extends StatelessWidget {
  const ProdutoPage({super.key});

  @override
  Widget build(BuildContext context) {
    /// Obtém a instância de Lista de Produtos usando o Provider.
    final ListaProdutos produtos = Provider.of<ListaProdutos>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Produtos'),
        centerTitle: true,
        actions: [
          // Pra criar um novo produto, vamos inserir um ícone de '+'
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PRODUTOS_FORM);
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          // Qtd de itens do provider
          itemCount: produtos.qtdItens,
          itemBuilder: (ctx, index) {
            // Vai passar o item do provider de indice index
            return Column(
              children: [
                ProdutoWidget(produto: produtos.itens[index]),
                const Divider(),
              ],
            );
          },
        ),
      ),
      drawer: const AppDrawer(),
    );
  }
}
