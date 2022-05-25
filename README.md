# Requisitos básicos do projeto


Swift 5
Xcode 
    13.4 (13F17a)
    
Arquitetura 
    MVVM-C
    
Auto-layout 
    - Desenvolvido com ViewCode, todo layout desenvolvido com contraints.
    
Carthage ou Cocoapods
    - Utilizado Cocoapods 
        - iCarousel (1.8.3)
        
Testes unitários
    - Feito teste unitário do contrato da API, mocando os dados.
    
Persistencia de dados 
    * CoreData

O projeto contem
    Carrossel superior com os 5 primeiros personagens
    Uma lista vertical abaixo do carrossel com os personagens seguintes, sem repetir
    Scroll infinito
        - Porem limitei a busca na api a 50 itens
        
GitFlow
    - Utilizei Forked Workflow
    - Desenvolvi basicamente tudo na master
    - Criei poucas branchs, devido ao pouco tempo acabei me concentrando no desenvolvimento e dexei meio de lado o GitFlow, sei que isso é desculpa mas fiz sem querer.
    
Testes
    - Teste unitário básico com json mockado.
    
Features
    - Criar um tela de detalhes 
        Nesta tela deve conter 
            - Imagem
            - Titulo
            - Detalhes
            - Botões que abrem uma WebView para
                - detail
                - wiki
                - comiclink
    
    - Criar testes de UI
    
