## Sobre
Este é um app que utiliza a <b><a href="https://developer.marvel.com/docs#!/public/getCreatorCollection_get_0">API da Marvel</a></b> para fazer uma listagem de personagens.

Na home do app, está listado, logo no topo, um carrossel com os 5 primeiros personagens, e logo em seguida os demais. Conforme o usuário interage com a lista e vai chegando ao seu  fim, novos personagens vão sendo carregados.

Na listagem, já são apresentados alguns ícones que dizem respeito as informações disponíveis para o determinado personagem, como:
- Histórias em quadrinho que ele aparece;
- Histórias que o personagem aparece;
- Eventos que ele esteve presente;
- Séries; e
- Links onde é possível encontrar mais informações sobre ele.

Ao selecionar algum personagem, a tela de informações é exibida, contendo toda a listagem de items, para que o usuário possa consumir os detalhes por categoria, além de visualizar uma imagem do personagem.

### Acessibilidade ♿️🔊
O app foi construído com ferramentas nativas e com os devidos cuidados para que seja acessível através da ferramenta de leitura de tela (VoiceOver).

### Capturas de tela
<img src="https://github.com/pauloatavila/marvel-characters/blob/main/screenshots/marvel_app.png" alt="Screenshot" width="782" height="500">

## Vem por aí
Uma melhoria simples e que já pode dar outro significado para a apresentação dos links extras, é a abertura deles diretamente no navegador do usuário, item que será feito em breve.

Uma feature legal para ser desenvolvida também, é um filtro de busca avançado: onde seja possível (de acordo com o permitido pela API da Marvel) selecionar determinados campos e parâmetros, tudo em uma interface agradável e fácil de mexer para o usuário.

## Papo de dev
Para criação do app, estão sendo utilizados como dependências o `Alamofire (5.2)` e `AlamofireImage (4.1)`, para facilitar a criação e tratamento de requisições e o controle de cache para as imagens, respectivamente. O gerenciador de dependências utilizado é o Cocoa Pods.

Para executar o projeto, basta fazer um clone, entrar na subpasta `/marvel-characters` e rodar o comando `pod install`.
