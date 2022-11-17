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
   DELETE Endpoint /viagens

# O teste abaixo falha porque a API retorna status 201, permitindo criar uma viagem com números no lugar do nome da pessoa.
# A documentação informa que o nome do acompanhante deve ser no formato string.
Cenario 03: POST Cadastrar Viagem Acompanhante Números 400
   [Tags]    ACNUMEROS    
   Criar User Admin Estatico e Armazenar Token    
   Selecionar Viagem Estatica "acompanhante_numeros"
   POST Endpoint /viagens
   Validar Status Code "400"

# Conforme esperado, a API não permitiu realizar o cadastro da viagem ao deixar uma das chaves da requisição sem valor
Cenario 04: POST Cadastrar Viagem Data Não Preenchida 400
   [Tags]    DATAINVALIDA    
   Criar User Admin Estatico e Armazenar Token    
   Selecionar Viagem Estatica "dataPartida_em_branco"
   POST Endpoint /viagens
   Validar Status Code "400"
   Validar Mensagem de Erro Status "Bad Request"

# O teste abaixo falha porque a API retorna 20, permitindo criar uma viagem mesmo com uma linha da requisição faltante.
# neste caso a linha com a chave da data de retorno e o seu valor. 
Cenario 05: POST Cadastrar Viagem Sem Data Retorno 400
   [Tags]    SEMDATARETORNO    
   Criar User Admin Estatico e Armazenar Token    
   Selecionar Viagem Estatica "sem_dataRetorno"
   POST Endpoint /viagens
   Validar Status Code "400"


   