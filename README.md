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