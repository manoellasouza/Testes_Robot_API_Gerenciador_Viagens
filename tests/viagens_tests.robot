*** Settings ***
Documentation        Arquivo de testes do endpoint /auth para gerar um token de acesso
Resource             ../support/base.robot

Suite Setup          Criar Sessao       

*** Test Cases ***
Cenario 01: GET Retorna todas as viagens 200
   [Tags]    GETVIAGENS 
   Criar User Padrão Estatico e Armazenar Token    
   GET Endpoint /viagens

Cenario 02: POST Cadastrar Viagem 201
   [Tags]    POSTVIAGENS 
   Criar User Admin Estatico e Armazenar Token    
   Selecionar Viagem Estatica "viagem_valida"
   POST Endpoint /viagens

# No teste abaixo a API permitiu criar uma viagem com números no lugar do nome da pessoa 
Cenario 03: POST Cadastrar Viagem Acompanhante Números 400
   [Tags]    ACINVALIDA 
   Criar User Admin Estatico e Armazenar Token    
   Selecionar Viagem Estatica "acompanhante_invalida"
   POST Endpoint /viagens
   