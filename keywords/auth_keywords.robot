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

Selecionar Auth Estatica Admin "${auth}"
    ${json}                               Importar JSON Estatico                 json_auth_admin.json  
    ${payload}                            Set variable                           ${json["${auth}"]}
    Set Global Variable                   ${payload}


Selecionar Auth Estatica User Padrão "${auth}"
    ${json}                               Importar JSON Estatico                 json_auth_usuario.json  
    ${payload}                            Set variable                           ${json["${auth}"]}
    Set Global Variable                   ${payload}

Criar User Admin Estatico e Armazenar Token
    Selecionar Auth Estatica Admin "auth_valida"
    POST Endpoint /auth

Criar User Padrão Estatico e Armazenar Token
    Selecionar Auth Estatica User Padrão "auth_valida"
    POST Endpoint /auth

Validar Ter Logado
    Should Not Be Empty        ${response.json()["data"]["token"]} 
    Should Be Empty            ${response.json()["errors"]}           

Validar Mensagem de Erro Status "${erro}"
    Should Be Equal            ${response.json()["error"]}            ${erro}

Validar Mensagem de Erro Tratamento "${erro}"
    Should Be Equal            ${response.json()["errors"][0]}            ${erro}


