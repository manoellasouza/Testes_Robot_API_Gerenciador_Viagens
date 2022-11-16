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