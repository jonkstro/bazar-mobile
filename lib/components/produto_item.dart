import 'package:bazar_do_bem/models/produto.dart';
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
          trailing: IconButton(
            onPressed: () {
              /// TODO: cart.addItem(product);
            },
            icon: const Icon(Icons.shopping_cart),
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        child: GestureDetector(
          child: Image.network(
            produto.imagemUrl,
            fit: BoxFit.cover,
          ),
          onTap: () {
            /// TODO: PushNamed para DetalheProdutoPage
          },
        ),
      ),
    );
  }
}
