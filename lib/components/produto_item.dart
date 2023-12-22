import 'package:bazar_do_bem/models/carrinho.dart';
import 'package:bazar_do_bem/models/produto.dart';
import 'package:bazar_do_bem/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProdutoItem extends StatelessWidget {
  const ProdutoItem({super.key});

  @override
  Widget build(BuildContext context) {
    /// Obtém uma referência ao objeto Produto a partir do Provider.
    /// O argumento 'listen: false' evita a reconstrução do widget quando o objeto Produto é alterado.
    final produto = Provider.of<Produto>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Produto>(
            /// Consumer é usado para ouvir mudanças no estado do Produto e
            /// reconstruir apenas essa parte do widget conforme mudar (coração).
            builder: (ctx, prod, _) => IconButton(
              onPressed: () {
                /// Vai chamar a função mudarFavorito no provider, que vai notificar
                /// a mudança aqui e vai alternar o icone de coração.
                prod.mudarIsFavorito();
              },
              icon: Icon(
                prod.isFavorito ? Icons.favorite : Icons.favorite_border,
              ),
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          title: Text(
            produto.nome,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
          trailing: Consumer<Carrinho>(
            builder: (context, carrinho, _) => IconButton(
              onPressed: () {
                carrinho.adicionarItem(produto);
              },
              // Se a qtd desse produto no carrinho for maior que zero vai exibir a qtd no icone cheio
              icon: carrinho.getQuantidadeItem(produto.id) > 0
                  ? Stack( //Stack vai botar o numero e o icone um em cima do outro
                      children: [
                        const Icon(Icons.shopping_cart),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            constraints: const BoxConstraints(minHeight: 16, minWidth: 16),
                            child: Text(
                              carrinho.getQuantidadeItem(produto.id).toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ),
                        )
                      ],
                    )
                  // Se a qtd desse produto no carrinho for igual a zero vai exibir o carrinho outlined
                  : const Icon(Icons.shopping_cart_outlined),
              color: Colors.deepOrange,
            ),
          ),
        ),
        // GestureDetector serve pra poder clicar na imagem sair pra pagina de Detalhe Produto
        child: GestureDetector(
          child: Image.network(
            produto.imagemUrl,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.DETALHE_PRODUTO, arguments: produto);
          },
        ),
      ),
    );
  }
}
