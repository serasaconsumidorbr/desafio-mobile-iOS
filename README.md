
<!-- Header-->
<p align="center">
<img src="https://cdn.marvel.com/content/1x/marvellogo_0.jpg" alt="Marvel Logo" width="500" height="250">
</p>
<h3 align="center">Desafio iOS - MarvelApp </h3>

## ✏️ Sobre o projeto
<p align="center">
O desafio consiste na criação de um aplicativo que apresente os personagens da Marvel vindos da API oficial. As especificações para interface do projeto são: 

* Carrossel superior com ****5**** personagens
* Uma lista ****vertical**** abaixo do carrossel ****com os personagens seguintes, sem repetir****
* Scroll infinito
</p>

## ✨ Demonstração

<p align="center">
  
<img src="/gif1.gif" alt="Simulator Recording" width="300">
  
<img src="/gif2.gif" alt="Simulator Recording" width="300">
  
</p>

A tela principal é construída na parte superior com uma CollectionView que atua como um carrossel, exibindo apenas 5 personagens principais. Cada personagem é apresentado com sua foto (se disponível na API), nome e descrição.

Abaixo do carrossel, temos outra CollectionView que mostra todos os outros personagens (excluindo aqueles já exibidos no carrossel) em uma lista vertical com scroll infinito. Essa lista é preenchida à medida que os dados são extraídos da API.

Todos os dados provenientes da API são tratados primeiro por uma camada de Network, que popula a ViewModel da página principal. Em seguida, a ViewModel se comunica com a View para atualizar a interface de acordo.



## 💻 Tecnologias utilizadas

* Swift 5+/Xcode 11+
* MVVM
* ViewCode, UIKit, SnapKit
* Cocoapods
* XCTest
* Lottie

 
## 🏹 Roadmap

*  Finalizar a implementação do CoreData, populando a Entity e trocando a referência da ViewModel
*  Implementar uma barra de pesquisa
*  Adicionar filtros, permitindo exibir a lista principal de personagens pelo filtro selecionado pelo usuário
*  Cobrir mais regras e casos de uso com os testes unitários
* Adicionar uma "página de perfil" do personagem, ao selecionar a célula de determinado personagem, contendo mais informações vindas do mesmo Endpoint


## 🧩 Installation

<p>

Para rodar o aplicativo localmente é necessário ter o sistema operacional MacOS com o Xcode IDE instalada.

Basta clonar o projeto ou baixá-lo localmente e abrir o arquivo `MarvelApp.xcworkspace`, após isso basta buildar o aplicativo pela IDE e ele poderá rodar no simulador de sua preferência e também em dispositivos físicos. 
</p>
