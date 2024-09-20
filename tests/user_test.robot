*** Settings ***

Resource            ../support/resources.resource

Documentation       This suite will test user endpoints
Metadata            Platform    API

Name                User Endpoints

Suite Setup         Setup Suites
Suite Teardown

*** Variables ***

${id}

*** Test Cases ***
POST Non Admin User Register Success
    [Documentation]    Create a new user with valid data and common access

    Faker Data

    ${headers}=    Headers Login
    ${body}=    Body User    false

    ${response}=    POST On Session    session    ${serverest.users}    json=${body}    headers=${headers}    expected_status=201

    ${id}=    Set Variable    ${response.json()['_id']}
    Should Not Be Empty    ${id}

    ${message}=    Set Variable    ${response.json()['message']}
    Should Be Equal    ${message}    Cadastro realizado com sucesso

    ${response}=    GET On Session    session    ${serverest.users}/${id}    headers=${headers}

    ${name_response}=    Set Variable    ${response.json()['nome']}
    Should Be Equal    ${name_response}    ${name}

    ${email_response}=    Set Variable    ${response.json()['email']}
    Should Be Equal    ${email_response}    ${email}

    # Delete user from database to keep it clean
    ${response}=    DELETE On Session    session    ${serverest.users}/${id}    expected_status=200

POST Admin User Register Success
    [Documentation]    Create a new user with valid data and admin access

    Faker Data

    ${headers}=    Headers Login
    ${body}=    Body User    true

    ${response}=    POST On Session    session    ${serverest.users}    json=${body}    headers=${headers}    expected_status=201

    ${id}=    Set Variable    ${response.json()['_id']}
    Should Not Be Empty    ${id}

    ${message}=    Set Variable    ${response.json()['message']}
    Should Be Equal    ${message}    Cadastro realizado com sucesso

    ${response}=    GET On Session    session    ${serverest.users}/${id}    headers=${headers}

    ${name_response}=    Set Variable    ${response.json()['nome']}
    Should Be Equal    ${name_response}    ${name}

    ${email_response}=    Set Variable    ${response.json()['email']}
    Should Be Equal    ${email_response}    ${email}

    # Delete user from database to keep it clean
    ${response}=    DELETE On Session    session    ${serverest.users}/${id}    expected_status=200

GET Search For Users In Database
    [Documentation]    Search on database for all users registered

    ${headers}    ${id}    ${response}=    POST User    false

    ${response}=    GET On Session     session    ${serverest.users}   headers=${headers}

    ${string_qnt}=    Convert To String    ${response.json()['quantidade']}
    Should Not Be Empty    ${string_qnt}
    Should Not Be Empty    ${response.json()['usuarios']}

    ${list}=    Evaluate    expression    ${response.json()} == list

    # Delete user from database to keep it clean
    ${response}=    DELETE On Session    session    ${serverest.users}/${id}    expected_status=200

GET Search For User Using ID
    [Documentation]    Search on database for an user by ID
    
    ${headers}    ${id}    ${response}=    POST User    false  

    ${response}=    GET On Session     session    ${serverest.users}/${id}   headers=${headers}

    ${name_response}=    Set Variable    ${response.json()['nome']}
    Should Be Equal    ${name_response}    ${name}

    ${email_response}=    Set Variable    ${response.json()['email']}
    Should Be Equal    ${email_response}    ${email}

    # Delete user from database to keep it clean
    ${response}=    DELETE On Session    session    ${serverest.users}/${id}    expected_status=200

PUT Create A New User When Try To Update With Non Existent ID
    [Documentation]    Use an invalid ID to update but create a new user instead

    Faker Data
    
    ${headers}=    Headers Login    
    ${body}=    Body User    false

    ${response}=    PUT On Session    session    ${serverest.users}/${invalid_id}    json=${body}    headers=${headers}

    ${message}=    Set Variable    ${response.json()['message']}
    Should Be Equal    ${message}    Cadastro realizado com sucesso

    # Delete user from database to keep it clean
    ${response}=    DELETE On Session    session    ${serverest.users}/${invalid_id}   expected_status=200