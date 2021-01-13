*** Settings ***
Resource        ../resource/Resource.robot
Test Setup      Abrir navegador
Test Teardown   Fechar navegador

*** Variables ***
#${URL}          http://automationpractice.com
#${BROWSER}      firefox

*** Test Case ***
Cenário 01: Pesquisar produto existente
    Dado que estou na página home do site
    Quando eu pesquisar pelo produto "T-shirts"
    Então o produto "T-shirts" deve ser listado na página de resultado da busca

Cenário 02: Pesquisar produto não existente
    Dado que estou na página home do site
    Quando eu pesquisar pelo produto "itemNãoExistente"
    Então a página deve exibir mensagem de erro "No results were found for your search "itemNãoExistente""

Cenário 03: Filtrar categoria de produto "falha de sistema"
  Dado que estou na página home do site
  Quando clico em "Dresses"
  E seleciono a categoria "Casual Dresses"
  Então o sistema exibe somente o item da categoria solicitada
