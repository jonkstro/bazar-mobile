import 'package:bazar_do_bem/models/produto.dart';
import 'package:flutter/material.dart';

class DetalheProdutoPage extends StatelessWidget {
  const DetalheProdutoPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Recupera o objeto Produto passado como argumento pela rota de navegação.
    final Produto produto =
        ModalRoute.of(context)?.settings.arguments as Produto;

    // Estrutura principal da página.
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(produto.nome),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Exibição da imagem do produto.
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                produto.imagemUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            // Exibição do preço do produto.
            Text(
              'R\$ ${produto.preco}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            // Exibição da descrição do produto.
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                produto.descricao,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
