*** Settings ***
Documentation        Keywords e Variaveis para Ações do enpoint Auth
Resource             ../support/base.robot

*** Keywords ***

GET Endpoint All /viagens
    &{header}                             Create Dictionary                  Authorization=${token}  
    ${response}                           GET On Session                       gerenciador-viagens        /viagens        headers=&{header}            expected_status=any
    Set Global Variable                   ${response}
    Log To Console                        ${response.content}
    Validar Content-type

GET Endpoint /viagens Região "${regiao}"
    &{header}                             Create Dictionary                  Authorization=${token}  
    ${response}                           GET On Session                      gerenciador-viagens        /viagens?${regiao}        headers=&{header}        expected_status=any
    Set Global Variable                   ${response}
    Log To Console                        ${response.content}
    Validar Content-type

GET Endpoint /viagens "${id_viagem}"
    &{header}                             Create Dictionary                  Authorization=${token}  
    ${response}                           GET On Session                      gerenciador-viagens        /viagens/${id_viagem}         headers=&{header}        expected_status=any
    Set Global Variable                   ${response}
    Log To Console                        ${response.content}
    Validar Content-type

POST Endpoint /viagens
    &{header}                             Create Dictionary                  Authorization=${token}                         
    ${response}                           POST On Session                    gerenciador-viagens                    /viagens        json=&{payload}        headers=&{header}        expected_status=any
    Log To Console                        ${payload}
    Log To Console                        Response: ${response.content}
    Set Global Variable                   ${response}
    Validar Content-type
    IF    "${response.status_code}" == "201"   
        ${id_viagem}                     Set Variable                        ${response.json()["data"]["id"]} 
        Set Global Variable               ${id_viagem} 
        Validar Ter Criado a Viagem
    END


DELETE Endpoint /viagens
    &{header}                             Create Dictionary                   Authorization=${token}  
    ${response}                           DELETE On Session                   gerenciador-viagens                    /viagens/${id_viagem}        headers=&{header}        expected_status=any
    Should Be True                        ${response.status_code} == 204 
    Log To Console                        Viagem de ID ${id_viagem} excluída com sucesso!
    # Set Global Variable                   ${response}

Selecionar Viagem Estatica "${viagem}"
    ${json}                               Importar JSON Estatico               json_viagem.json  
    ${payload}                            Set variable                         ${json["${viagem}"]}
    Set Global Variable                   ${payload}

Validar Ter Criado a Viagem
    Should Not Be Empty                        ${response.json()["data"]}        
    Should Be Empty                            ${response.json()["errors"]} 

Criar Viagem Válida e Armazenar ID
    Selecionar Viagem Estatica "viagem_valida"
    POST Endpoint /viagens