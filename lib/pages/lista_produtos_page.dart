import 'package:bazar_do_bem/components/app_drawer.dart';
import 'package:bazar_do_bem/components/carrinho_badge.dart';
import 'package:bazar_do_bem/components/produto_grid.dart';
import 'package:bazar_do_bem/enums/filtro_enum.dart';
import 'package:bazar_do_bem/models/carrinho.dart';
import 'package:bazar_do_bem/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Será statefull, pois terá filtragem de favoritos
class ListaProdutosPage extends StatefulWidget {
  const ListaProdutosPage({super.key});

  @override
  State<ListaProdutosPage> createState() => _ListaProdutosPageState();
}

class _ListaProdutosPageState extends State<ListaProdutosPage> {
  bool _mostrarFavoritos = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Minha Loja'),
        centerTitle: true,
        actions: [
          /// Popup são os botões que vai ter pra escolher
          PopupMenuButton(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),

            /// Alterar a cor de fundo da seleção pra branco, pois veio default azul
            surfaceTintColor: Colors.white,
            icon: const Icon(Icons.more_horiz),
            iconSize: 30,
            itemBuilder: (_) => [
              /// Se apertar no item o valor que vai receber é o enum FAVORITOS
              const PopupMenuItem(
                value: FiltroEnum.FAVORITOS,
                child: Text(
                  'Somente Favoritos',
                  style: TextStyle(fontSize: 16),
                ),
              ),

              /// Se apertar no item o valor que vai receber é o enum TODOS
              const PopupMenuItem(
                value: FiltroEnum.TODOS,
                child: Text(
                  'Mostrar Todos',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],

            /// Vai chamar o onSelected passando o enum como valor
            /// se o valor passado for favorito, só mostra favoritos (true)
            onSelected: (FiltroEnum valorEscolhido) {
              setState(() {
                if (valorEscolhido == FiltroEnum.FAVORITOS) {
                  _mostrarFavoritos = true;
                } else {
                  _mostrarFavoritos = false;
                }
              });
            },
          ),
          Consumer<Carrinho>(
            /// Aqui vai ter um consumer que vai atualizar a qtd de itens no ícone do carrinho
            /// passando pro CarrinhoBadge o número e o ícone do carrinho.
            builder: (context, carrinho, _) => CarrinhoBadge(
              value: carrinho.qtdItens.toString(),
              child: IconButton(
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 20,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.CARRINHO);
                },
                icon: const Icon(Icons.shopping_cart),
                iconSize: 30,
              ),
            ),
          ),
        ],
      ),
      body: ProdutoGrid(mostrarSomenteFavorito: _mostrarFavoritos),
      drawer: const AppDrawer(),
    );
  }
}
