# MarvelCharactersApp Documentation

Este documento tem como objetivo fornecer uma documentação detalhada do aplicativo Marvel Characters, desenvolvido em Swift com View Code na arquitetura MVVM.

## Fluxo de pensamentos

O desenvolvimento do aplicativo foi feito seguindo a arquitetura MVVM, que tem como objetivo separar responsabilidades e tornar o código mais organizado. Para isso, primeiramente, foi feita uma análise do que seria necessário para o aplicativo, como fontes de dados, design e funcionalidades. Em seguida, foi feita a escolha das bibliotecas e ferramentas que seriam utilizadas para o desenvolvimento.

## Imagens do App

![appPrints](https://github.com/irixsrs/desafio-mobile-iOS/assets/97895129/2c24dec1-5178-4036-a262-c4d2ceb885be)

## Bibliotecas e suas versões

### RxSwift

A biblioteca RxSwift foi escolhida para lidar com a parte reativa do aplicativo. Com ela, foi possível implementar ações reativas, como a atualização da lista de personagens da Marvel. A versão utilizada foi a 5.1.1.

O RxSwift é uma biblioteca que permite programação reativa no iOS. Programação reativa é um paradigma de programação que se concentra em fluxos de dados e na propagação de mudanças. Com o RxSwift, é possível criar fluxos de dados que reagem às mudanças de entrada e produzem resultados de saída.

### SDWebImage

A biblioteca SDWebImage foi utilizada para carregar e armazenar em cache as imagens dos personagens. Com ela, foi possível carregar as imagens de forma assíncrona e com cache, melhorando a performance do aplicativo. A versão utilizada foi a 5.11.2.

O SDWebImage é uma biblioteca para download de imagens da web. Ele baixa as imagens de forma assíncrona e armazena em cache, o que pode melhorar significativamente a performance do aplicativo. O SDWebImage também fornece recursos para exibir as imagens, como suporte para animações de carregamento e tratamento de erros.

### CocoaPods

O gerenciador de dependências CocoaPods foi utilizado para instalar e gerenciar as bibliotecas utilizadas no aplicativo. Com ele, foi possível manter as dependências atualizadas e separadas do código do projeto.

O CocoaPods é um gerenciador de dependências para projetos iOS e macOS. Ele automatiza o processo de baixar, instalar e gerenciar bibliotecas de terceiros em um projeto. O uso do CocoaPods torna mais fácil manter as dependências atualizadas e separadas do código do projeto.

## Funcionalidades

O aplicativo consiste em uma lista de personagens da Marvel, ordenados por ordem alfabética. Cada personagem é exibido com uma foto e uma descrição, quando disponível. As informações dos personagens são obtidas através da API pública da Marvel.

A lista de personagens é atualizada automaticamente quando chega ao fim da página, carregando mais personagens.

## Roadmap de features futuras e melhorias

Algumas features futuras e melhorias que poderiam ser implementadas no aplicativo são:

- Adicionar mais informações sobre os personagens, como os quadrinhos em que eles aparecem;
- Adicionar pesquisa e filtros na lista de personagens, permitindo que o usuário possa buscar por personagens específicos ou organizar a lista de acordo com suas preferências;
- Adicionar uma navegação para detalhes do personagem, com todas as informações disponíveis na API;
- Adicionar opção de favoritar personagens e manter uma lista dos personagens favoritados para acesso do usuário;

Essas features podem tornar o aplicativo mais informativo e completo. Dessa forma, os usuários teriam acesso a uma gama maior de informações e poderiam se aprofundar ainda mais no universo Marvel.
