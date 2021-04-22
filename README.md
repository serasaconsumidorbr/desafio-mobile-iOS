## Sobre
<p> iOS App para buscar lista de personagens da Marvel.</p>

<p><b>Atenção:</b> Adicionar as suas chaves <a href="https://developer.marvel.com/documentation/authorization">Marvel</a> no arquivo <b>EndPointType.swift</b> para rodar o projeto</p>

# Libs usadas
    > Alamofire
    > PromisseKit

## Melhorias
<p>Estas são sugestões de melhorias a serem desenvolvidas no projeto.</p>

* Adicionar uma CollectionView no `CharactersListViewController.swift` no topo da tela com **5** personagens e mostrar na tableview abaixo os  com os personagens seguintes, sem repetir.

* Separar as chaves em um arquivo .plist e carregar elas no arquivo `EndPointType.swift`

* Adicionar testes unitários no interector `CharacterDetailsInteractor.swift`  para validar os cenários quando os dados são recebidos ou não.  E também validar outras areas que fizerem sentido serem testadas.

* Criar um sistema de cache para evitar o uso desnecessário de dados.

* Melhorar a parte de UX do app com algumas animações e um design mais intuitivo e bonito.

* Componentizar algumas partes do app como a camada de `Network` e montar um  `Core` com os operadores e as extensions.

* Criar um ícone para App.


## Imagens do projeto

![Alt text](/preview/1.png?raw=true "Lista de personagens")
![Alt text](/preview/2.png?raw=true "Detalhes do personagem")
![Alt text](/preview/3.png?raw=true "Erro na busca dos personagens")
![Alt text](/preview/4.png?raw=true "Lista vazia")
