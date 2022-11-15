#Seção para configuração, documentação, imports de arquivos e libraries, etc
*** Settings ***
Documentation        Arquivo simples para requisições HTTP em APIs REST
Library              RequestsLibrary
Library              OperatingSystem

Resource             ./common/common.robot
Resource             ./variables/variables.robot
Resource             ../keywords/auth_keywords.robot

*** Keywords ***
Criar Sessao              
    Create Session        gerenciador-viagens        ${BASE_URI}  