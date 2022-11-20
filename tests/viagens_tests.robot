*** Settings ***
Documentation        Arquivo de testes do endpoint /auth para gerar um token de acesso
Resource             ../support/base.robot

Suite Setup          Criar Sessao       

*** Test Cases ***

# Apenas a autorização do user padrão consegue utilizar o GET /viagens
Cenario 01: GET Retorna Todas As Viagens 200
   [Tags]    GETVIAGENS 
   Criar User Padrão Estatico e Armazenar Token    
   GET Endpoint All /viagens
   Validar Status Code "200"

Cenario 02: GET Retorna Todas As Viagens Admin 403
   [Tags]    GETVIAGENSADMIN
   Criar User Admin Estatico e Armazenar Token     
   GET Endpoint All /viagens
   Validar Status Code "403"
   Validar Mensagem de Erro Status "Forbidden"
   Validar Mensagem Response "Acesso negado"

Cenario 03: GET Retorna Todas As Viagens Token Inválido 401
   [Tags]    GETVIAGENSTOKENINVALIDO
   Selecionar Token Invalido     
   GET Endpoint All /viagens
   Validar Status Code "401"
   Validar Mensagem de Erro Status "Unauthorized"
   Validar Mensagem Response "Acesso negado. Você deve estar autenticado no sistema para acessar a URL solicitada."

Cenario 04: GET Retorna Viagens Por Região 200
   [Tags]    GETVIAGENSREGIAO 
   Criar User Padrão Estatico e Armazenar Token    
   GET Endpoint /viagens Região "regiao=Sudeste"
   Validar Status Code "200"
   # Ver se eu consigo mexer no arquivo do bando de dados pra deixar o cadastro sempre igual

# Sugestão melhoria: Adicionar o erro 500 (Internal Server Error) e a mensagem "Não existem viagens cadastradas para esta Região" ao Swagger,
# pois elas só existem no código da API
Cenario 05: GET Retorna Viagens Região Inválida 500
   [Tags]    GETVIAGENSREGIAOINVALIDA 
   Criar User Padrão Estatico e Armazenar Token    
   GET Endpoint /viagens Região "regiao=12345"
   Validar Status Code "500"
   Validar Mensagem de Erro Status "Internal Server Error"
   Validar Mensagem Response "Não existem viagens cadastradas para esta Região"

Cenario 06: POST Cadastrar Viagem 201
   [Tags]    POSTVIAGENS 
   Criar User Admin Estatico e Armazenar Token    
   Selecionar Viagem Estatica "viagem_valida"
   POST Endpoint /viagens
   DELETE Endpoint /viagens

# O teste abaixo falha porque a API retorna status 201, permitindo criar uma viagem com números no lugar do nome da pessoa.
# A documentação informa que o nome do acompanhante deve ser no formato string.
Cenario 07: POST Cadastrar Viagem Acompanhante Números 400
   [Tags]    ACNUMEROS    
   Criar User Admin Estatico e Armazenar Token    
   Selecionar Viagem Estatica "acompanhante_numeros"
   POST Endpoint /viagens
   DELETE Endpoint /viagens
   Validar Status Code "400"

Cenario 08: POST Cadastrar Viagem Data Não Preenchida 400
   [Tags]    DATAINVALIDA    
   Criar User Admin Estatico e Armazenar Token    
   Selecionar Viagem Estatica "dataPartida_em_branco"
   POST Endpoint /viagens
   Validar Status Code "400"
   Validar Mensagem de Erro Status "Bad Request"

# O teste abaixo falha porque a API retorna 201, permitindo criar uma viagem mesmo com uma linha da requisição faltante.
# neste caso a linha com a chave da data de retorno e o seu valor. 
Cenario 09: POST Cadastrar Viagem Sem Data Retorno 400
   [Tags]    SEMDATARET   
   Criar User Admin Estatico e Armazenar Token    
   Selecionar Viagem Estatica "sem_dataRetorno"
   POST Endpoint /viagens
   DELETE Endpoint /viagens
   Validar Status Code "400"

Cenario 10: POST Cadastrar Viagem Token Inválido 401
   [Tags]    POSTTOKENINVALIDO  
   Selecionar Token Invalido
   Selecionar Viagem Estatica "viagem_valida"
   POST Endpoint /viagens
   Validar Status Code "401"
   Validar Mensagem de Erro Status "Unauthorized"
   Validar Mensagem Response "Acesso negado. Você deve estar autenticado no sistema para acessar a URL solicitada."
 
 Cenario 11: POST Cadastrar Viagem User Padrão 403
   [Tags]    POSTTOKENUSER
   Criar User Padrão Estatico e Armazenar Token
   Criar Viagem Válida e Armazenar ID
   Validar Status Code "403"
   Validar Mensagem de Erro Status "Forbidden"
   Validar Mensagem Response "Acesso negado"

# Ao logar com admin para criar um produto e em seguida logar como user padrão para pesquisar a viagem pelo ID criado, a API retorna 
# o seguinte: A API do Tempo não está online. Erro 422
Cenario 12: GET Buscar Viagem Específica 200
    [Tags]    GETVIAGEMESP
    Criar User Admin Estatico e Armazenar Token
    Criar Viagem Válida e Armazenar ID
    Criar User Padrão Estatico e Armazenar Token
    GET Endpoint /viagens "${id_viagem}"
    Validar Status Code "200"
    DELETE Endpoint /viagens

Cenario 13: GET Buscar Viagem Específica Não Encontrada 404
    [Tags]    GETVIAGEMESPINVALIDA
    Criar User Padrão Estatico e Armazenar Token
    GET Endpoint /viagens "12589"
    Validar Status Code "404"
    Validar Mensagem de Erro Tratamento "Viagem com id: [12589] não encontrada"





















# Sugestão melhoria: Adicionar mensagem de response ao código da API informando ao usuário que a viagem foi deletada com sucesso
Cenario 06: DELETE Viagem 204
   [Tags]    DELETEVIAGEM    
   Criar User Admin Estatico e Armazenar Token 
   Selecionar Viagem Estatica "viagem_valida"
   POST Endpoint /viagens   
   DELETE Endpoint /viagens



   