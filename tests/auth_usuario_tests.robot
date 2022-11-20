*** Settings ***
Documentation        Arquivo de testes do endpoint /auth para gerar um token de acesso para usuário padrão
Resource             ../support/base.robot

Suite Setup          Criar Sessao       

*** Test Cases ***
Cenario 01: POST Autenticação Estática Usuário Valida 200
   [Tags]    AUTHVALIDA 
   Selecionar Auth Estatica User Padrão "auth_valida"
   POST Endpoint /auth
   Validar Status Code "200"
   Validar Ter Logado

Cenario 02: POST Autenticação Estática E-mail Não Cadastrado 401
   [Tags]    EMAILNAOCAD 
   Selecionar Auth Estatica User Padrão "email_nao_cadastrado"
   POST Endpoint /auth
   Validar Status Code "401"
   Validar Mensagem de Erro Status "Unauthorized"
   Validar Mensagem Response "Acesso negado. Você deve estar autenticado no sistema para acessar a URL solicitada."

Cenario 03: POST Autenticação Estática Senha Incorreta 401
   [Tags]    SENHAINC 
   Selecionar Auth Estatica User Padrão "senha_incorreta"
   POST Endpoint /auth
   Validar Status Code "401"
   Validar Mensagem de Erro Status "Unauthorized"
   Validar Mensagem Response "Acesso negado. Você deve estar autenticado no sistema para acessar a URL solicitada."

Cenario 04: POST Autenticação Estática E-mail Formato Inválido 400
   [Tags]    EMAILINVALIDO
   Selecionar Auth Estatica User Padrão "email_invalido"
   POST Endpoint /auth
   Validar Status Code "400"
   Validar Mensagem de Erro Tratamento "Email inválido."

Cenario 05: POST Autenticação Estática Sem Senha 400
   [Tags]    SEMSENHA 
   Selecionar Auth Estatica User Padrão "sem_senha"
   POST Endpoint /auth
   Validar Status Code "400"
   Validar Mensagem de Erro Tratamento "Senha não pode ser vazia."

Cenario 06: POST Autenticação Estática Sem E-mail 400
   [Tags]    SEMEMAIL 
   Selecionar Auth Estatica User Padrão "sem_email"
   POST Endpoint /auth
   Validar Status Code "400"
   Validar Mensagem de Erro Tratamento "Email não pode ser vazio."

# O teste abaixo falha porque a API retorna status 200, realizando a autenticação mesmo com a senha sendo em formato de números. 
# A documentação informa que o formato do valor desta chave deve ser do tipo string.
Cenario 07: POST Autenticação Estática Senha Números 400
   [Tags]    SENHANUMERO 
   Selecionar Auth Estatica User Padrão "senha_numero"
   POST Endpoint /auth
   Validar Status Code "400"