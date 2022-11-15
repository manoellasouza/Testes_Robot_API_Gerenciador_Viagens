*** Settings ***
Documentation        Arquivo de testes do endpoint /auth para gerar um token de acesso
Resource             ../support/base.robot

Suite Setup          Criar Sessao       

*** Test Cases ***
Cenario 01: POST Autenticação Estática Valida 200
   [Tags]    AUTHVALIDA 
   Selecionar Auth Estatica "auth_valida"
   POST Endpoint /auth
   Validar Status Code "200"
   Validar Ter Logado

Cenario 02: POST Autenticação Estática E-mail Não Cadastrado 401
   [Tags]    EMAILNAOCAD 
   Selecionar Auth Estatica "email_nao_cadastrado"
   POST Endpoint /auth
   Validar Status Code "401"
   Validar Mensagem de Erro "Unauthorized"

# O teste abaixo retorna erro 400 (bad request). Este erro não consta como uma possível response na documentação da API.
Cenario 03: POST Autenticação Estática E-mail Inválido 
   [Tags]    EMAILINVALIDO
   Selecionar Auth Estatica "email_invalido"
   POST Endpoint /auth

Cenario 04: POST Autenticação Estática Senha Incorreta 401
   [Tags]    SENHAINC 
   Selecionar Auth Estatica "senha_incorreta"
   POST Endpoint /auth
   Validar Status Code "401"
   Validar Mensagem de Erro "Unauthorized"

# O teste abaixo retorna erro 400 (bad request). Este erro não consta como uma possível response na documentação da API.
Cenario 05: POST Autenticação Estática Sem Senha 
   [Tags]    SEMSENHA 
   Selecionar Auth Estatica "sem_senha"
   POST Endpoint /auth

# O teste abaixo retorna erro 400 (bad request). Este erro não consta como uma possível response na documentação da API.
Cenario 06: POST Autenticação Estática Sem E-mail 
   [Tags]    SEMEMAIL 
   Selecionar Auth Estatica "sem_email"
   POST Endpoint /auth

