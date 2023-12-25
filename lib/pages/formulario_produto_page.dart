import 'package:bazar_do_bem/models/lista_produtos.dart';
import 'package:bazar_do_bem/models/produto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormularioProdutoPage extends StatefulWidget {
  const FormularioProdutoPage({super.key});

  @override
  State<FormularioProdutoPage> createState() => _FormularioProdutoPageState();
}

class _FormularioProdutoPageState extends State<FormularioProdutoPage> {
  /// Controller que vai servir pras validações do campo de url de imagem
  final _imagemUrlController = TextEditingController();

  /// Chave que vai identificar o FORM para podermos interagir com ele "de fora"
  final _keyFormulario = GlobalKey<FormState>();

  /// Os dados do formulário vão ser jogados nesse mapping de String(chave) / Object(vai ter
  /// diferentes dados no form [string/double/ind]...). Esses dados vão ser jogados no provider
  /// do ListaProdutos para poder fazer o seu CREATE/UPDATE.
  final _dadosFormulario = Map<String, Object>();

  // Método que vai atualizar a imagem na FittedBox.
  // o setState vazio já é suficiente pra refreshar a imagem com a url
  void atualizarImagem() {
    // Neste caso, ele não contém nenhuma lógica específica (o corpo está vazio), mas apenas
    // chama setState para sinalizar que o estado do widget mudou e precisa ser reconstruído.
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // Adiciona um ouvinte ao controlador _imagemUrlController. Isso significa que sempre que
    // o valor do controlador for alterado, o método atualizarImagem será chamado.
    _imagemUrlController.addListener(atualizarImagem);
  }

  @override
  void dispose() {
    super.dispose();
    // O método dispose está sendo usado para desvincular o ouvinte _imageUrlController
    // do método updateImage durante a fase de descarte do widget.
    // Isso é uma boa prática para evitar problemas de performance e vazamentos de memória.
    _imagemUrlController.removeListener(atualizarImagem);
  }

  // didChangeDependencies é um método do ciclo de vida do Flutter que é chamado quando as
  // dependências do widget mudam. Isso pode acontecer quando o widget é construído pela
  // primeira vez ou quando as dependências (como tema ou localização) mudam.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Esse método vai preencher o formdata com o produto passado por argumento
    if (_dadosFormulario.isEmpty) {
      // Se _dadosFormulario estiver vazio, obtém as dependências do produto da rota
      final arg = ModalRoute.of(context)?.settings.arguments;
      if (arg != null) {
        // Se arg (dependencias) não for nulo, estamos navegando para a tela de edição
        final Produto produto = arg as Produto;
        // Preenche os dados dos textos do formulário com os dados do produto que foi
        // recebido pelas dependencias no argumento da rota
        _dadosFormulario['id'] = produto.id;
        _dadosFormulario['nome'] = produto.nome;
        _dadosFormulario['preco'] = produto.preco;
        _dadosFormulario['descricao'] = produto.descricao;
        _dadosFormulario['imagemUrl'] = produto.imagemUrl;
        // Atualiza o texto do controlador _imageUrlController com a URL da imagem do produto
        _imagemUrlController.text = produto.imagemUrl;
      }
    }
  }

  // Vai salvar cada um dos campos do form chamando o onSaved de cada um
  void _submitFormulario() {
    // Validação dos campos do formulario: Se tiver o que validar ele valida,
    //se não tiver nada pra validar (chave for vazia) manda false pois deu algum erro
    final isValid = _keyFormulario.currentState?.validate() ?? false;
    // Se não for válido (isValid = false) ele vai fazer nada, vai acabar aqui
    if (!isValid) {
      return;
    }

    _keyFormulario.currentState?.save();

    // Chamando o método que vai CRIAR/ATUALIZAR o produto pelo provider de ListaProdutos
    // Pra não dar erro, vai ter que botar listen = false, pois está fora do build.
    Provider.of<ListaProdutos>(
      context,
      listen: false,
    ).createProduto(_dadosFormulario);
    // Voltar pra tela anterior:
    Navigator.of(context).pop();
  }

  // Método que vai validar a URL da imagem que vai ser adicionada pra não dar erro de imagem
  bool isValidImagemUrl(String url) {
    // Vai pegar o caminho absoluto da URL, se não tiver vai pegar false (não válido)
    bool isValidImagemUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    return isValidImagemUrl;

    /// OPCIONAL: Validação do final da URL se termina com algum formato de imagem
    // bool endsWithFile = url.toLowerCase().endsWith('.png') ||
    //     url.toLowerCase().endsWith('.jpg') ||
    //     url.toLowerCase().endsWith('.jpeg');
    // return isValidImageUrl && endsWithFile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _dadosFormulario.isEmpty
            ? const Text('Cadastrar novo produto')
            : Text('Editar o produto ${_dadosFormulario['nome'].toString()}'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              _submitFormulario();
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          // Vamos identificar o formulário pela chave dele
          key: _keyFormulario,
          child: ListView(
            children: [
              TextFormField(
                // Se tiver dados vem pro campo pra editar, senão é só o campo vazio
                initialValue: _dadosFormulario['nome']?.toString(),
                decoration: const InputDecoration(
                  label: Text('Nome'),
                  enabledBorder: UnderlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
                // Se clicar no ENTER do teclado vai pro próximo input do form
                textInputAction: TextInputAction.next,
                // Ao submitar o form, o formdata vai receber no campo nome o valor
                // do textfield, senão, se tiver vazio (??) vai receber '' (string vazia).
                onSaved: (nome) => _dadosFormulario['nome'] = nome ?? '',
                // VALIDAÇÕES DO CAMPO:
                validator: (value) {
                  final String nome = value ?? '';
                  // Validar se tá só espaço em branco:
                  if (nome.trim().isEmpty) {
                    return 'O campo nome é obrigatório';
                  }

                  // Aqui iremos primeiro remover todos espaços em branco para poder depois
                  // medir a quantidade de letras e ver se tem mais de 5 caracteres
                  if (nome.replaceAll(' ', '').length < 5) {
                    return 'Nome precisa ter pelo menos 5 caracteres';
                  }

                  // Quando tem return null quer dizer que não teve erros
                  return null;
                },
              ),
              const SizedBox(height: 25),
              TextFormField(
                // Se tiver dados vem pro campo pra editar, senão é só o campo vazio
                initialValue: _dadosFormulario['preco']?.toString(),
                decoration: const InputDecoration(
                  label: Text('Preço'),
                  enabledBorder: UnderlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
                // Se clicar no ENTER do teclado vai pro próximo input do form
                textInputAction: TextInputAction.next,
                // Precisa desse decimal = true pq o IOS não tem vírgula
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                // Ao submitar o form, o formdata vai receber no campo preco o valor
                // do textfield, senão, se tiver vazio (??) vai receber '0' (vai parsear 0.0).
                onSaved: (preco) =>
                    _dadosFormulario['preco'] = double.parse(preco ?? '0'),
                validator: (value) {
                  final String precoString = value ?? '';
                  // Vamos tentar parsear o valor da string, se não conseguir mete um -1 pra dar erro
                  final double preco = double.tryParse(precoString) ?? -1;

                  if (preco <= 0) {
                    return 'Insira um preço válido';
                  }

                  // Quando tem return null quer dizer que não teve erros
                  return null;
                },
              ),
              const SizedBox(height: 25),
              TextFormField(
                // Se tiver dados vem pro campo pra editar, senão é só o campo vazio
                initialValue: _dadosFormulario['descricao']?.toString(),
                decoration: const InputDecoration(
                  label: Text('Descricao'),
                  enabledBorder: UnderlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
                // Se clicar no ENTER do teclado vai pro próximo input do form
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                // Ao submitar o form, o formdata vai receber no campo descricao o valor
                // do textfield, senão, se tiver vazio (??) vai receber '' (string vazia).
                onSaved: (descricao) =>
                    _dadosFormulario['descricao'] = descricao ?? '',
                // VALIDAÇÕES DO CAMPO:
                validator: (value) {
                  final String descricao = value ?? '';
                  // Validar se tá só espaço em branco:
                  if (descricao.trim().isEmpty) {
                    return 'O campo descricao é obrigatório';
                  }

                  // Aqui iremos primeiro remover todos espaços em branco para poder depois
                  // medir a quantidade de letras e ver se tem mais de 5 caracteres
                  if (descricao.replaceAll(' ', '').length < 15) {
                    return 'Descricao precisa ter pelo menos 15 caracteres';
                  }

                  // Quando tem return null quer dizer que não teve erros
                  return null;
                },
              ),
              const SizedBox(height: 25),
              Row(
                // Pra deixar o textfield e a box do container alinhados no chão
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Url da Imagem',
                        enabledBorder: UnderlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      // A partir do controller vamos acessar o texto pra poder
                      // mostrar o container com a imagem da url.
                      controller: _imagemUrlController,

                      /// OPCIONAL: Quando for submitado vai chamar o submitform
                      // onFieldSubmitted: (_) => _submitFormulario(),

                      // Ao submitar o form, o formdata vai receber no campo imagemUrl o valor
                      // do textfield, senão, se tiver vazio (??) vai receber '' (string vazia).
                      onSaved: (imagemUrl) =>
                          _dadosFormulario['imagemUrl'] = imagemUrl ?? '',
                      // VALIDAÇÕES DO CAMPO:
                      validator: (value) {
                        final String imagemUrl = value ?? '';
                        if (isValidImagemUrl(imagemUrl) == false) {
                          return 'Informe uma URL válida';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  // Esse container vai exibir a imagem certinha
                  Container(
                    // Pra não ficar colado na de cima e no textfield
                    margin: const EdgeInsets.only(top: 10, left: 10),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: _imagemUrlController.text.isEmpty
                        ? const Text('Insira uma URL')
                        : FittedBox(
                            fit: BoxFit.cover,
                            child: Image.network(
                              _imagemUrlController.text,
                              errorBuilder: (context, error, stackTrace) {
                                return const Text(
                                  'URL inválida ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 20),
                                  softWrap: true,
                                );
                              },
                            ),
                          ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
