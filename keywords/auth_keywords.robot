*** Settings ***
Documentation        Keywords e Variaveis para Ações do enpoint Auth
Resource             ../support/base.robot

*** Keywords ***

POST Endpoint /auth
    ${response}                           POST On Session                       gerenciador-viagens        /auth                   json=&{payload}        expected_status=any
    Log To Console                        ${payload}
    Log To Console                        Response: ${response.content}
    Set Global Variable                   ${response}  
    Validar Content-type
    IF    "${response.status_code}" == "200"   
        ${token}                        Set Variable        ${response.json()["data"]["token"]} 
        Set Global Variable               ${token} 
    END

Selecionar Auth Estatica "${auth}"
    ${json}                               Importar JSON Estatico                 json_auth.json  
    ${payload}                            Set variable                           ${json["${auth}"]}
    Set Global Variable                   ${payload}

Criar Um Usuario Estatico e Armazenar Token
    Selecionar Auth Estatica "auth_valida"
    POST Endpoint /auth

Validar Ter Logado
    Should Not Be Empty        ${response.json()["data"]["token"]} 
    Should Be Empty            ${response.json()["errors"]}           

Validar Mensagem de Erro "${erro}"
    Should Be Equal            ${response.json()["error"]}            ${erro}
