*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}      firefox
${URL}          http://automationpractice.com
${LOGIN_URL}    http://automationpractice.com/index.php?controller=authentication&back=my-account
${EMAIL}        vitor.vieira10@hotmail.com
${SENHA}        testesenha



*** Keywords ***
#### Setup e Teardown
Abrir navegador
    Open Browser    about:blank   ${BROWSER}

Fechar navegador
    Close Browser

#### Ações
#Acessar a página home do site
####Dado
Dado que estou na página home do site
    Go To               ${URL}
    Title Should Be     My Store

Dado que estou na página de login
    Go To               ${LOGIN_URL}
    Title Should Be     Login - My Store


####Quando
Quando eu pesquisar pelo produto "${produto}"
    Input Text          name=search_query    ${PRODUTO}
    Click Element       name=submit_search

Quando clico em "Dresses"
    Click Element       xpath=//*[@id="block_top_menu"]/ul/li[2]/a

Quando informo as credenciais válidas
    Input Text          id=email    ${EMAIL}
    Input Text          id=passwd   ${SENHA}

Quando informo credenciais inválidas
  Input Text            id=email    ${EMAIL}
  Input Text            id=passwd   invalida

####E
E seleciono a categoria "Casual Dresses"
      Click Element    id=layered_category_9

E clico no botão "Sign in"
      Click Element    css=#SubmitLogin > span

####Então
Então o produto "${PRODUTO}" deve ser listado na página de resultado da busca
    Wait Until Element Is Visible   css=#center_column > h1
    Title Should Be                 Search - My Store
    Page Should Contain Image       xpath=//*[@id="center_column"]//*[@src='${URL}/img/p/1/1-home_default.jpg']
    Page Should Contain Link        xpath=//*[@id="center_column"]//a[@class="product-name"][contains(text(),"${PRODUTO}")]

Então a página deve exibir mensagem de erro "${MENSAGEM_ALERTA}"
    Wait Until Element Is Visible   xpath=//*[@id="center_column"]/p[@class='alert alert-warning']
    Element Text Should Be          xpath=//*[@id="center_column"]/p[@class='alert alert-warning']    ${MENSAGEM_ALERTA}

Então o sistema exibe somente o item da categoria solicitada
  Title Should Be                     Dresses - My Store
  Page Should Contain Element         xpath=//*[@id="center_column"]/ul/li[1]/div/div[1]/div/a[1]/img
  Page Should Not Contain Element     xpath=//*[@id="center_column"]/ul/li[2]/div/div[1]/div/a[1]/img
  Page Should Not Contain Element     xpath=//*[@id="center_column"]/ul/li[3]/div/div[1]/div/a[1]/img
  Page Should Not Contain Element     xpath=//*[@id="center_column"]/ul/li[4]/div/div[1]/div/a[1]/img
  Page Should Not Contain Element     xpath=//*[@id="center_column"]/ul/li[5]/div/div[1]/div/a[1]/img

Então sou redirecionado para a página "My account"
  Title Should Be                Login - My Store
  Page Should Contain Element    css=#columns > div.breadcrumb.clearfix > span.navigation_page

Então sistema retorna mensagem de erro "${ERRO_LOGIN}"
  Sleep    1s
  Element Text Should Be         css=#center_column > div:nth-child(2) > ol:nth-child(2) > li:nth-child(1)    ${ERRO_LOGIN}
