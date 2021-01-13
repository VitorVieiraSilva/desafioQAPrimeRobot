*** Settings ***
Resource        ../resource/Resource.robot
Test Setup      Abrir navegador
Test Teardown   Fechar navegador

*** Variables ***


*** Test Case ***
Cenário 01: Realizar login com sucesso
   Dado que estou na página de login
   Quando informo as credenciais válidas
   E clico no botão "Sign in"
   Então sou redirecionado para a página "My account"

Cenário 02: Erro login invalid password
  Dado que estou na página de login
  Quando informo credenciais inválidas
  E clico no botão "Sign in"
  Então sistema retorna mensagem de erro "Authentication failed."
