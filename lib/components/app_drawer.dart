import 'package:bazar_do_bem/utils/app_routes.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      surfaceTintColor: Colors.white,
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text('Bem Vindo!!!'),
            centerTitle: true,
            // Aqui vai esconder o ícone do drawer quando abrir ele
            automaticallyImplyLeading: false,
          ),
          Divider(color: Theme.of(context).colorScheme.primary),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Loja'),
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.HOME);
            },
          ),
          const Divider(color: Colors.grey, height: 1),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Pedidos'),
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.PEDIDOS);
            },
          ),
          const Divider(color: Colors.grey, height: 1),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Gerenciar Produtos'),
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.PRODUTOS);
            },
          ),
        ],
      ),
    );
  }
}
