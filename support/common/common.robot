*** Settings ***
Documentation        Keywords e Variaveis para Ações Gerais
Library              OperatingSystem  
Library              Collections 

*** Keywords ***

Importar JSON Estatico
    [Arguments]    ${nome_arquivo}
    ${arquivo}     Get File      ${EXECDIR}/support/fixtures/static/${nome_arquivo} 
    ${data}        Evaluate      json.loads('''${arquivo}''')    json  
    [return]       ${data}

Validar Status Code "${statuscode}"
    Should Be True        ${response.status_code} == ${statuscode} 
    Log To Console        Status Code Retornado: ${response.status_code}

Validar Content-type
    ${response.value}=       Get From Dictionary       ${response.headers}        content-type 
    Should Be Equal          ${response.value}       application/json;charset=UTF-8