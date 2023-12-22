/// Essa classe vai ser usada pela model Carrinho.
class CarrinhoItem {
  final String id;
  final String idProduto;
  final String nome;
  final int quantidade;
  final double preco;

  CarrinhoItem({
    required this.id,
    required this.idProduto,
    required this.nome,
    required this.quantidade,
    required this.preco,
  });
}
