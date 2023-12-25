# Bazar do Bem

Projeto com fins educacionais para aprender o uso de Providers no Flutter para gerenciamento de estado da aplicação

Projeto que estou me baseando:
https://vscode.dev/github/jonkstro/cod3r-shopping

## Passo 1:
Alterar o pubspec yaml adicionando:
    `provider: ^5.0.0`
    `intl: ^0.17.0`


## Passo 2:
Criar as models dentro de lib que irão ter os Providers
Vamos iniciar criando Product e ProductList (Vai listar os dados do Dummy_Data)


## Passo 3:
Criar os componentes e páginas e adicionar elas junto do MultiProvider no Main.
- Estaremos usando GridView na pagina de DetalhesProdutos onde chamaremos um GridTile em um componente separado. Esse componente terá itens favoritados pra ser mostrado no GridView.
- Criado o componente ProdutoItem que vai adicionar como favorito e também vai adicionar itens ao carrinho. Mas para isso será preciso criar a Model de Carrinho e o seu Provider.


## Passo 4:
Criar a Model de Carrinho e adicionar ela no Main e no componente ProdutoItem.
- A model de Carrinho precisará de outra model CarrinhoItem, onde irão listar cada produto


## Passo 5:
Criar a page DetalheProdutoPage e CarrinhoPage
- Adicionar nos utils e nas routes do Main.
- Criar o componente CarrinhoItemWidget pra poder botar na CarrinhoPage.


## Passo 6:
Criar a model Pedidos e ListaPedidos que irão ser receber os itens que forem enviados do carrinho quando apertar o botão "Comprar".
- Adicionar no Main o Create do Provider de ListaPedidos
- Adicionar no CarrinhoPage a função de addPedido usando o provider criado de ListaPedidos. Obs.: No CarrinhoPage deve-se atentar de deixar o listen = false.


## Passo 7:
Criar o componente Pedido e página PedidoPage que vão listar os pedidos realizados após apertar o botão de "Comprar".
- Após criar a página PedidoPage, adicionar ela no approutes e no main.
- Obs.: O componente Pedido irá expandir e retrair ao clicar no IconButton do trailing. Por isso, precisará ser um componente Stateful. Além disso, esse componente vai receber um pedido da PedidoPage como parametro no construtor.
- Obs2.: O componente Pedido irá realizar formatação de datas, pra isso, será preciso instalar a dependência INTL no pubspec.yml 


## Passo 8:
Criar o componente Drawer que vai alternar entre as páginas e adicionar nas páginas principais que estão no approutes: (home / pedidos / gerenciar produtos)

### Snackbar
SnackBar vai mostrar que o produto foi adicionado, e vai permitir desfazer tbm
- Criar método na model Carrinho removerUmItem para remover só 1 item ao clicar em 'DESFAZER' no snackbar.
- Criar SnackBar no onPressed do ícone de carrinho do componente ProdutoItem.
### Confirmação com Dialog
Vamos adicionar um Dialog no Dismissable do componente CarrinhoItemWidget pra ter que confirmar antes de deletar o item do carrinho
- Vai ser adicionado um confirmDismis no Dismissed com o widget AlertDialog que vai retornar um future com true (pra confirmar que quer remover o item do carrinho) ou false (pra cancelar a remoção do item do carrinho) e após isso o onDismissed vai excluir ou não.


## Passo 9: 
Criar a página ProdutoPage e FormularioProdutoPage para isso, será preciso criar também um novo componente ProdutoWidget que vai ser um ListTile que vai ser carregado pela página ProdutoPage.

### CRUD
Antes de criar o componente e as telas, serão preciso adicionar na model ListaProduto os métodos do CRUD
- CREATE - Foi criado o método saveProduct na model ProductList que vai receber o formData da página ProductFormPage e vai adicionar na lista dos produtos. Posteriormente esse método pode ser alterado para salvar em um banco de dados ou fazer uma chamada de API.

- UPDATE - Foi criado o método updateProduct que vai ser chamado no saveProduct no provider ProductList, pra, quando identificar que o produto tem um ID, ele chamar o método de updateProduct ao invés de addProduct. Além disso foi adicionado no icone de edição no componente do ProductItem para ir para a mesma página ProductFormPage, só que passando como argumento o produto que vai editar.

- DELETE - Foi criado o método removeProduct na model ProductList que vai ser chamado no componente ProductItemWidget onde foi colocado tbm um showDialog. Se apertar o showDialog em SIM ele vai chamar o removeProduct no Provider de ProductList.

### Tela de Produtos
- Criar pagina ProdutoPage e adicionar no AppRoutes e nas routes do Main
- Essa página vai ter um ListView que vai chamar o componente ProdutoWidget passando como parâmetro o Provider de ListaProdutos, onde vai ter todos itens já cadastrados.

### Tela de Formulário de Produtos
- Criar pagina FormularioProdutoPage e adicionar no AppRoutes e no main nas routes.
- A página vai ser Statefull pois vai ser preciso gerenciamento de estados e validações.
- A página ProductFormPage terá um widget Form que irá ter os TextFormFields dos campos necessários para cadastrar um novo produto
- Nessa página foi feito validação dos campos usando validate do form e submit usando onSaved do form.




- Componente ProdutoWidget vai receber um produto no seu construtor, que vai ser passado pela ProdutoPage.
