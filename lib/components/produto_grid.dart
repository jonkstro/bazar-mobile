import 'package:bazar_do_bem/components/produto_item.dart';
import 'package:bazar_do_bem/models/lista_produtos.dart';
import 'package:bazar_do_bem/models/produto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProdutoGrid extends StatelessWidget {
  /// Vai filtrar pra mostrar só os itens que tão favoritados
  final bool mostrarSomenteFavorito;
  const ProdutoGrid({super.key, required this.mostrarSomenteFavorito});

  @override
  Widget build(BuildContext context) {
    /// Os produtos serão passados e atualizados pelo provider
    final provider = Provider.of<ListaProdutos>(context);

    /// Se receber mostrarSomenteFavorito = true, então o provider vai chamar
    /// o getter de somente favoritos, senão vai chamar o getter de todos itens
    final List<Produto> produtosCarregados =
        mostrarSomenteFavorito ? provider.itensFavoritos : provider.itens;

    // Obtém a largura da tela
    double larguraTela = MediaQuery.of(context).size.width;

    // Calcula o número de colunas com base na largura da tela
    int crossAxisCount =
        (larguraTela / 300).floor(); // 150 é a largura desejada de cada item

    return GridView.builder(
      padding: const EdgeInsets.all(10),

      /// A qtd que vai carregar é o length (10)
      itemCount: produtosCarregados.length,
      itemBuilder: (ctx, index) {
        /// Tamos envolvendo com ChangeNotifier pra ele "escutar" as alterações
        /// de favorito e atualizar a tela. Sem precisar ser statefull.
        /// Aqui está sendo usado o ChangeNotifier.value pq ele já foi criado lá no Produto que foi carregado
        return ChangeNotifierProvider.value(
          /// Utiliza o ChangeNotifierProvider para fornecer o estado (Produto) ao widget filho.
          value: produtosCarregados[index],
          child: const ProdutoItem(),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 3 / 2, //Proporção da box, 3x / 2y
        crossAxisSpacing: 10, //Espaço horizontal
        mainAxisSpacing: 10, //Espaço vertical
      ),
    );
  }
}
