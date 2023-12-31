import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

// import '../data/dummy_data.dart';
import 'produto.dart';

import 'package:flutter/foundation.dart';

// Classe que representa uma lista de produtos e notifica os ouvintes quando há mudanças.
class ListaProdutos with ChangeNotifier {
  // Lista interna de produtos, inicializada com dados fictícios (DUMMY_PRODUTOS).
  // final List<Produto> _itens = DUMMY_PRODUTOS;
  final List<Produto> _itens = []; // Vai ser carregado pelo backend agora

  // URL do backend hospedado no railway, temos que usar o https pra funcionar
  final _url = Uri.https('bazar-backend.up.railway.app', 'produto');

  // Getter para obter uma cópia imutável da lista de produtos.
  List<Produto> get itens {
    return [..._itens];
  }

  // Getter para receber a contagem de itens
  int get qtdItens {
    return _itens.length;
  }

  // Getter para obter uma lista apenas dos produtos marcados como favoritos.
  List<Produto> get itensFavoritos {
    return _itens.where((prod) => prod.isFavorito).toList();
  }

  // Método que vai carregar os itens do backend na página inicial e na página de produtos
  Future<void> carregarProdutos() async {
    // antes de carregar na lista ela vai ser limpa, pra evitar duplicidade
    _itens.clear();
    // vai dar erro se for firebase e não tiver .json no final, como é backend do railway
    // espera-se que não seja preciso.
    final response = await http.get(_url);
    List<dynamic> dados = jsonDecode(response.body);
    // Percorrer os itens
    for (var item in dados) {
      _itens.add(
        Produto(
          id: item['id'].toString(),
          nome: item['nome'],
          descricao: item['descricao'],
          preco: item['preco'],
          imagemUrl: item['imagemUrl'],
        ),
      );
    }
    notifyListeners(); // Notifica os ouvintes (como widgets) sobre a mudança nos dados.
  }

  /// CRUD - INÍCIO
  // Método que vai criar um novo produto, é possível customizar para salvar em BD depois
  // vai ser passado como parâmetro os dados enviados pela página de Formulário.
  Future<void> createProduto(Map<String, Object> dados) {
    // verificar se já tem algum id no produto passado, se já tiver um id, vai atualizar
    // ao invés de adicionar novo produto na memória/BD
    bool hasId = dados['id'] != null;

    final produto = Produto(
      // Tem ID? Se sim vai receber o mesmo ID, senão vai ser gerado um novo aleatório
      id: hasId ? dados['id'].toString() : Random().nextDouble().toString(),
      nome: dados['nome'].toString(),
      descricao: dados['descricao'].toString(),
      preco: double.parse(dados['preco'].toString()),
      imagemUrl: dados['imagemUrl'].toString(),
    );

    // Tem ID? Se sim, vai chamar o update, senão vai criar um novo produto
    return hasId ? updateProduto(produto) : addProduto(produto);

    /// OBS.: NÃO VAI PRECISAR NOTIFICAR COM NOTIFY LISTENERS POIS JÁ TEM NO UPDATE E ADDPRODUTO
  }

  // Método para adicionar um novo produto à lista e notificar os ouvintes sobre a mudança.
  Future<void> addProduto(Produto produto) async {
    // await vai esperar esse método até receber uma resposa
    final response = await http.post(
      _url,
      body: jsonEncode({
        'nome': produto.nome,
        'descricao': produto.descricao,
        'preco': produto.preco,
        'imagemUrl': produto.imagemUrl,
      }),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
    );
    final id = jsonDecode(response.body)['id'];
    // Adicionar em memória um produto com o ID retornado pelo Backend
    _itens.add(
      Produto(
        id: id.toString(),
        nome: produto.nome,
        descricao: produto.descricao,
        preco: produto.preco,
        imagemUrl: produto.imagemUrl,
      ),
    );
    notifyListeners(); // Notifica os ouvintes (como widgets) sobre a mudança nos dados.
  }

  // Método que vai atualizar os dados de um produto já existente.
  Future<void> updateProduto(Produto produto) async {
    // Se não achar o indice o indexWhere retorna index = -1, se achar retorna o indice
    int index = _itens.indexWhere((element) => element.id == produto.id);
    if (index >= 0) {
      // Se indice achado for > -1 então achou, esse item então vai receber o produto recebido
      _itens[index] = produto;
      notifyListeners(); // Notifica os ouvintes (como widgets) sobre a mudança nos dados.
    }
  }

  void deleteProduto(Produto produto) {
    // Se não achar o indice o indexWhere retorna index = -1, se achar retorna o indice
    int index = _itens.indexWhere((element) => element.id == produto.id);
    if (index >= 0) {
      // Se indice achado for > -1 então achou, logo removerá o product
      _itens.removeWhere((element) => element.id == produto.id);
    }
    notifyListeners(); // Notifica os ouvintes (como widgets) sobre a mudança nos dados.
  }

  /// CRUD - FIM
}
