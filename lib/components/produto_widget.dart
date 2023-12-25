import 'package:bazar_do_bem/models/lista_produtos.dart';
import 'package:bazar_do_bem/models/produto.dart';
import 'package:bazar_do_bem/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProdutoWidget extends StatelessWidget {
  final Produto produto;
  const ProdutoWidget({super.key, required this.produto});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(produto.imagemUrl),
      ),
      title: Text(produto.nome),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.edit),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes.PRODUTOS_FORM, arguments: produto);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Theme.of(context).colorScheme.error,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      // Mudar a cor do material3 que vem azul
                      backgroundColor: Colors.white,
                      title: const Text('Tem certeza que quer excluir?'),
                      content: Text(
                        'Quer realmente excluir o produto ${produto.nome} ?',
                        textAlign: TextAlign.center,
                      ),
                      actions: [
                        TextButton(
                          child: const Text(
                            'Não',
                          ),
                          onPressed: () {
                            // Fechar a tela de popup voltando false.
                            Navigator.of(context).pop(false);
                          },
                        ),
                        TextButton(
                          child: const Text(
                            'Sim',
                          ),
                          onPressed: () {
                            // Fechar a tela de popup voltando true.
                            Navigator.of(context).pop(true);
                          },
                        ),
                      ],
                    );
                  },
                ).then((value) {
                  // Se fechar o popup voltando true (apertando em SIM)
                  if (value == true) {
                    // Se for excluir vai chamar o removeProduct do provider
                    // Obs.: O listen tem que tar igual false, pra não quebrar tudo!!!
                    Provider.of<ListaProdutos>(
                      context,
                      listen: false,
                    ).deleteProduto(produto);
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
