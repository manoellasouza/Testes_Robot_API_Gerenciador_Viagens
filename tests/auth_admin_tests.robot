*** Settings ***
Documentation        Arquivo de testes do endpoint /auth para gerar um token de acesso para admin
Resource             ../support/base.robot

Suite Setup          Criar Sessao       

*** Test Cases ***
Cenario 01: POST Autenticação Estática Valida 200
   [Tags]    AUTHVALIDA 
   Selecionar Auth Estatica Admin "auth_valida"
   POST Endpoint /auth
   Validar Status Code "200"
   Validar Ter Logado

Cenario 02: POST Autenticação Estática E-mail Não Cadastrado 401
   [Tags]    EMAILNAOCAD 
   Selecionar Auth Estatica Admin "email_nao_cadastrado"
   POST Endpoint /auth
   Validar Status Code "401"
   Validar Mensagem de Erro "Unauthorized"

# O teste abaixo retorna erro 400 (bad request). Este erro não consta como uma possível response na documentação da API.
Cenario 03: POST Autenticação Estática E-mail Inválido 
   [Tags]    EMAILINVALIDO
   Selecionar Auth Estatica Admin "email_invalido"
   POST Endpoint /auth
   Validar Status Code "400"

Cenario 04: POST Autenticação Estática Senha Incorreta 401
   [Tags]    SENHAINC 
   Selecionar Auth Estatica Admin "senha_incorreta"
   POST Endpoint /auth
   Validar Status Code "401"
   Validar Mensagem de Erro "Unauthorized"

# O teste abaixo retorna erro 400 (bad request). Este erro não consta como uma possível response na documentação da API.
Cenario 05: POST Autenticação Estática Sem Senha 
   [Tags]    SEMSENHA 
   Selecionar Auth Estatica Admin "sem_senha"
   POST Endpoint /auth
   Validar Status Code "400"

# O teste abaixo retorna erro 400 (bad request). Este erro não consta como uma possível response na documentação da API.
Cenario 06: POST Autenticação Estática Sem E-mail 
   [Tags]    SEMEMAIL 
   Selecionar Auth Estatica Admin "sem_email"
   POST Endpoint /auth
   Validar Status Code "400"

# O documento da API informa que e-mail e senha devem ser do tipo string, porém ao testar a senha como um número (sem aspas) o teste passa normalmente
Cenario 07: POST Autenticação Estática Senha Números 
   [Tags]    SENHANUMERO 
   Selecionar Auth Estatica Admin "senha_numero"
   POST Endpoint /auth
   Validar Status Code "400"


