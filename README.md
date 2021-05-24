[![Tuist badge](https://img.shields.io/badge/Powered%20by-Tuist-blue)](https://tuist.io)


## Modularização
[![](https://mermaid.ink/img/eyJjb2RlIjoiZ3JhcGggVEQ7XG5cbkFbW0FwcF1dO1xuQltBcHBDb3JlXTtcbkNbQXBwQ29yZVVJXTtcbkRbRmVhdHVyZV07XG5IW1tVSURlbW9dXTtcbkpbW0ZlYXR1cmVEZW1vXV07XG5LW05ldHdvcmtdO1xuTFtSZXBvc2l0b3J5XTtcblxuQi0tPkM7XG5DLS0-RDtcbkQtLT5BO1xuQy0tPkg7XG5ELS0-SjtcbkwtLT5EO1xuSy0tPkw7XG5CLS0-SztcbiIsIm1lcm1haWQiOnt9LCJ1cGRhdGVFZGl0b3IiOmZhbHNlfQ)](https://mermaid-js.github.io/mermaid-live-editor/#/edit/eyJjb2RlIjoiZ3JhcGggVEQ7XG5cbkFbW0FwcF1dO1xuQltBcHBDb3JlXTtcbkNbQXBwQ29yZVVJXTtcbkRbRmVhdHVyZV07XG5IW1tVSURlbW9dXTtcbkpbW0ZlYXR1cmVEZW1vXV07XG5LW05ldHdvcmtdO1xuTFtSZXBvc2l0b3J5XTtcblxuQi0tPkM7XG5DLS0-RDtcbkQtLT5BO1xuQy0tPkg7XG5ELS0-SjtcbkwtLT5EO1xuSy0tPkw7XG5CLS0-SztcbiIsIm1lcm1haWQiOnt9LCJ1cGRhdGVFZGl0b3IiOmZhbHNlfQ)


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

* Abusar um pouco mais dos loadings;

* Melhorar o darkmode em componentes padrões do sistema (searchbar)

* Criar um sistema de dimensões centralizado, ao invés de colocar os valores das constraints de forma hardcoded 

* Utilizar o Swiftgen para acessar recursos

------------

## O App

[![Watch the video](https://img.youtube.com/vi/eacoiOoAMvk/0.jpg)](https://youtu.be/eacoiOoAMvk)

* clique na imagem para ver o vídeo no youtube.

O aplicativo já contém ícone, suporte a imagens dentro da tabela sem conflito, suporte a darkmode e uma searchbar para poder realizar pesquisas de personagens.

A pesquisa está "protegida" com o uso de debouncer's, ou seja, a pesquisa só será feita após o usuário ficar x tempo sem digitar nada.


![simulator_screenshot_825C81FC-AB39-4326-8A36-DD9884E198D3](https://user-images.githubusercontent.com/7849484/119412597-88d0e180-bcc2-11eb-9c74-ae51d44e8bbf.png)



### DarkMode

![simulator_screenshot_5810529E-5255-46DC-834F-F73522CC035C](https://user-images.githubusercontent.com/7849484/119412437-414a5580-bcc2-11eb-9bb9-489771ce6dc3.png)
![simulator_screenshot_FAB13DA0-0B9C-4F74-91EB-4994CCE80412](https://user-images.githubusercontent.com/7849484/119412454-48716380-bcc2-11eb-9b95-03b483f88e52.png)
![simulator_screenshot_30F2F51D-DBAE-4115-BD82-ACED0E7ED95F](https://user-images.githubusercontent.com/7849484/119412467-4f987180-bcc2-11eb-9122-b4f771077603.png)
![simulator_screenshot_C1BCD754-FE74-4F7A-9567-D4456BD5996A](https://user-images.githubusercontent.com/7849484/119412480-58894300-bcc2-11eb-9f07-8e020967096f.png)
![simulator_screenshot_BA6235FF-4FC5-4308-8C6E-2C89826FCB75](https://user-images.githubusercontent.com/7849484/119412511-663ec880-bcc2-11eb-95d2-f5d267b7f64c.png)

### LightMode

![simulator_screenshot_4A128D2D-6CE0-4EBE-8D58-0D54CDB737C9](https://user-images.githubusercontent.com/7849484/119412654-9edea200-bcc2-11eb-9258-0e297f245e8a.png)
![simulator_screenshot_35637BD8-3752-4A77-8052-E45C61929AFC](https://user-images.githubusercontent.com/7849484/119412707-b0c04500-bcc2-11eb-98be-cc887764cd56.png)
![simulator_screenshot_02765B9B-0F6B-482D-8641-18FFD340B422](https://user-images.githubusercontent.com/7849484/119412682-a7cf7380-bcc2-11eb-8410-9a938e4c974d.png)
![simulator_screenshot_B7C5308D-5C40-497B-8070-4EE4BC5C0204](https://user-images.githubusercontent.com/7849484/119412740-bfa6f780-bcc2-11eb-86e6-da38a44f312a.png)
![simulator_screenshot_2210D7DA-CCFD-4820-A758-30229E488253](https://user-images.githubusercontent.com/7849484/119412754-c6ce0580-bcc2-11eb-9665-49d0421d1b5b.png)

