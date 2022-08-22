<!-- Header-->
<br />
<p align="center">
  <a>
    <img src="https://i.imgur.com/vkpMB6l.png" alt="Logo" width="200" height="120">
  </a>

  <h3 align="center">Aplicativo Marvel - Henrique Legnaro </h3>
</p>

## Arquitetura / Design Pattern
<p>
    O aplicativo foi desenvolvido utilizando o padrão TDD (Test-Driven Development), onde comecei pela criação dos testes unitários do repositório, deixando eles guiarem o desenvolvimento.
</p>

<p>
  A arquitetura utilizada foi o MVP (Model - View - Presenter), onde o Presenter fica responsável por chamar a API por meio do Repository e passar os dados formatados por meio de uma View Model para a View Controller que fica responsável apenas por mostrar os dados para o usuário, populando o Carrossel e a Table View e também registrar as interações.
</p>


## Bibliotecas Externas
<p>
Todas as bibliotecas foram instaladas utilizando o Cocoapods e o Podfile se encontra no repositório.
</p>
<p>
* Hash
</p>  
<p>
Utilizada para criptografar as chaves da API com o algoritimo md5, assim conformando com os requisitos de utilização da mesma.
</p> 
<p>
* SDWebImage
</p> 
<p>
Utilizada para baixar as imagens contidas tanto no carrossel, quanto na table view, por meio da URL obtida pelo retorno da API.
</p> 
<p>
* lottie-ios
</p>
<p>
Utilizada para a criação de animações personalizadas.
</p>

## Persistencia de dados 
<p>
Utilizei o Core Data para salvar localmente os primeiros 50 personagens recebidos pela API, esses personagens são salvos no retorno inicial da API, são carregados quando o APP é aberto e depois ocorre uma chamada de atualização dos mesmos.
</p>

## Gitflow
<p>
    O projeto foi desenvolvido na branch develop e mergeado na branch main ao ser finalizado, simulando um ambiente de produção.
    </p>
    <p>
        Como o APP foi feito do zero e apenas por um desenvolvedor, a entrega aconteceu com base na tela construida e não dividida por features.
        </p>


## Futuras Implementações
<p>
    O projeto foi finalizado com cobertura de 70,6% por testes unitários, então deixo como pendência técnica a implementação de mais testes, principalmente no Presenter e na View Controller.
    </p>
<p>
    O APP possuí apenas um tratamento de erro genérico, que é comunicado para o usuário por meio de um Alert, no futuro pretendo criar erros personalizados melhorando o feedback de erro.
    </p>
<p>
    Algumas funções implementadas por meio da biblioteca SDWebImage, utilizadas para baixar as imagens pela URL, ficaram sem tratamento de erro e foram utilizadas de forma insegura, o que pode gerar problemas, planejo adotar todos os tratamentos de segurança necessários. 
    </p>

## Prints
<p>
<a>
    <img src="https://i.imgur.com/VVOuw3c.png" alt="Logo" width="250" height="400">
  </a>
    <a>
    <img src="https://i.imgur.com/r2QDo29.png" alt="Logo" width="250" height="400">
  </a>
</p>
