[![Tuist badge](https://img.shields.io/badge/Powered%20by-Tuist-blue)](https://tuist.io)


## Modularização

[![]([![](https://mermaid.ink/img/eyJjb2RlIjoiZ3JhcGggVEQ7XG5cbkFbW0FwcF1dO1xuQltBcHBDb3JlXTtcbkNbQXBwQ29yZVVJXTtcbkRbRmVhdHVyZV07XG5IW1tVSURlbW9dXTtcbkpbW0ZlYXR1cmVEZW1vXV07XG5LW05ldHdvcmtdO1xuTFtSZXBvc2l0b3J5XTtcblxuQi0tPkM7XG5DLS0-RDtcbkQtLT5BO1xuQy0tPkg7XG5ELS0-SjtcbkstLT5EO1xuTC0tPks7XG5CLS0-TDtcbiIsIm1lcm1haWQiOnt9LCJ1cGRhdGVFZGl0b3IiOmZhbHNlfQ)](https://mermaid-js.github.io/mermaid-live-editor/#/edit/eyJjb2RlIjoiZ3JhcGggVEQ7XG5cbkFbW0FwcF1dO1xuQltBcHBDb3JlXTtcbkNbQXBwQ29yZVVJXTtcbkRbRmVhdHVyZV07XG5IW1tVSURlbW9dXTtcbkpbW0ZlYXR1cmVEZW1vXV07XG5LW05ldHdvcmtdO1xuTFtSZXBvc2l0b3J5XTtcblxuQi0tPkM7XG5DLS0-RDtcbkQtLT5BO1xuQy0tPkg7XG5ELS0-SjtcbkstLT5EO1xuTC0tPks7XG5CLS0-TDtcbiIsIm1lcm1haWQiOnt9LCJ1cGRhdGVFZGl0b3IiOmZhbHNlfQ))


A ideia por trás desta modularização é ter um nível maior de separação de responsabilidades e otimização do build da aplicação, uma vez que é possível rodar features da aplicação de forma isolada.

Obs: Este é um diagrama geral da arquitetura, a implementação segue estas premissas, mas tem módulos extras. Os módulos foram criados utilizando SPM (Swift Package Manager).

Também fiquei sem tempo hábil para criar os app's demos para mostrar apenas uma funcionalidade, mas a ideia seria criar um "component book" para demonstrar todo o design system do app. Também criar app's para rodar funcionalidades de forma isolada do restante do aplicativo.

## Bibliotecas

```
Alamofire
Lottie
PromiseKit
Realm
SDWebImage
SnapKit
Swinject
```

* Alamofire: Biblioteca utilizada para abstrair a camada HTTP do aplicativo (se encontra completamente isolada dentro do pacote `Network`, podendo ser fácilmente substituída no futuro)

* Lottie: Animação (loading)

* PromiseKit: Biblioteca utilizada para facilitar o uso de código assíncrono, em próximas etapas seria útil para encadeamento de tarefas assíncronas etc.

* Realm: Bando de dados local, encontra-se completamente isolado dentro do pacote `Repository`, sendo assim facilmente substituído por qualquer outro meio de storage (CoreData, arquivos criptografados etc).

* SDWebImage: Carregamento e cacheamento de imagens, esta lib foi colocada apenas para dar agilidade ao desenvolvimento, mas o ideal é que seja substituída por algum outro tipo de metodologia para imagens remotas, para não depender de uma lib de terceiros.

* SnapKit: DSL para facilitar a criação de constraints em view-code, torando assim o código mais idiomático e de mais fácil compreensão.

* Swinject: Dependency Injector, uma das premissas da modularização é que os módulos não acessem diretamente as classes de outro módulo, sendo assim, toda a comunicação inter-módulos é feita através do DI, cada módulo pode expor somente apenas protocolos de forma pública (facilitando assim testes e o princípio de Linskov etc)

--------------


## Execução

Para executar o aplicativo é preciso criar um arquivo `Configurations/iOS/MarvelConfig.xcconfig` o conteúdo deste arquivo deve ser:

```
MARVEL_API_PUBLIC_KEY =
MARVEL_API_PRIVATE_KEY =
```

Além disso é necessário ter instalado a ferramenta [tuist](https://tuist.io/), para abrir o projeto basta executar:

```bash
tuist focus App
```

-------------

## Melhorias

* Criar os app's com features isoladas e handbook de componentes

* Melhorar a cena "uCharacterDetail" para que trate quando o personagem não for encontrado no BD local (criando um novo endpoint de detail e o chamando se necessáiro)

* Atualização dinâmica do tamanho do carousel ao deitar o aplicativo

* Escrever testes para as duas telas (escrevi alguns poucos testes para garantir o comportamento do realm e de algumas extensions), com o clean-swift (design pattern adotado) isso seria relativamente simples, cada camada da cena pode ser subtituída e mocada facilmente durante os testes (apenas criando stubs em conformidade com os mesmos protocolos)

* Criar um backend que fique responsável por chamar as API's da Marvel, uma vez que em produção a chave poderia ser facilmente extraída do aplicativo utilizando engenharia reversa.

* Abusar um pouco mais dos loadings

------------

## O App


