import 'package:bazar_do_bem/models/carrinho.dart';
import 'package:bazar_do_bem/models/lista_pedidos.dart';
import 'package:bazar_do_bem/pages/carrinho_page.dart';
import 'package:bazar_do_bem/pages/detalhes_produto_page.dart';
import 'package:bazar_do_bem/pages/formulario_produto_page.dart';
import 'package:bazar_do_bem/pages/pedidos_page.dart';
import 'package:bazar_do_bem/pages/produto_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/lista_produtos_page.dart';
import '../models/lista_produtos.dart';
import '../utils/app_routes.dart';

void main() {
  // Inicia a execução do aplicativo chamando a função runApp com a instância de MyApp.
  runApp(const MyApp());
}

// Classe principal do aplicativo Flutter.
class MyApp extends StatelessWidget {
  // Construtor que chama o construtor da superclasse (StatelessWidget).
  const MyApp({Key? key}) : super(key: key);

  // Método responsável por construir a interface do aplicativo.
  @override
  Widget build(BuildContext context) {
    // Retorna um widget MultiProvider, que permite fornecer vários provedores de estado.
    return MultiProvider(
      providers: [
        // Provedor de Mudança de Notificador para a Lista de Produtos.
        ChangeNotifierProvider(create: (_) => ListaProdutos()),
        ChangeNotifierProvider(create: (_) => Carrinho()),
        ChangeNotifierProvider(create: (_) => ListaPedidos()),

        // Adicione mais provedores conforme necessário para diferentes estados.
      ],
      child: MaterialApp(
        // Título do aplicativo que aparece na barra de título do dispositivo.
        title: 'Bazar do Bem',
        // Configuração do tema visual do aplicativo.
        theme: ThemeData(
          // Ativa o uso do Material 3, a versão mais recente do Material Design.
          useMaterial3: true,
          // Esquema de cores personalizado, com as cores primária e secundária definidas.
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.purple,
            secondary: Colors.deepOrange,
            error: Colors.red,
          ),
          // Define a fonte padrão para todo o aplicativo como 'Lato'.
          fontFamily: 'Lato',
        ),
        // Página inicial do aplicativo, que exibe a lista de produtos.
        // Vai ficar comentada pra podermos deixar o home no routes como '/'.
        // Só pode deixar um ou outro pra não dar erro.
        // home: const ListaProdutosPage(),
        routes: {
          AppRoutes.HOME: (context) => const ListaProdutosPage(),
          AppRoutes.DETALHE_PRODUTO: (context) => const DetalheProdutoPage(),
          AppRoutes.CARRINHO: (context) => const CarrinhoPage(),
          AppRoutes.PEDIDOS: (context) => const PedidosPage(),
          AppRoutes.PRODUTOS: (context) => const ProdutoPage(),
          AppRoutes.PRODUTOS_FORM: (context) => const FormularioProdutoPage(),
        },
        // Remover a flag de debug:
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
