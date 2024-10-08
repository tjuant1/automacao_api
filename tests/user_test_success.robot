*** Settings ***

Resource            ../support/resources.resource

Documentation       This suite contains all success tests of users endpoints
Metadata            Platform    API

Name                User Endpoints Success

Suite Setup         Setup Suites

*** Test Cases ***
POST - Non Admin User Register Success
    [Documentation]    Create a new user with valid data and common access
    [Tags]    user

    Faker Data

    ${headers}=    Headers Login
    ${body}=    Body User    false

    ${response}=    POST On Session    session    ${serverest.users}    json=${body}    headers=${headers}    expected_status=201

    ${id}=    Set Variable    ${response.json()['_id']}
    Should Not Be Empty    ${id}

    Should Be Equal    ${response.json()['message']}    ${messages['register_success']}

    ${response}=    GET On Session    session    ${serverest.users}/${id}    headers=${headers}

    Should Be Equal    ${response.json()['nome']}    ${name}

    Should Be Equal    ${response.json()['email']}    ${email}

    ${response}=    DELETE On Session    session    ${serverest.users}/${id}    expected_status=200

POST - Admin User Register Success
    [Documentation]    Create a new user with valid data and admin access
    [Tags]    user

    Faker Data

    ${headers}=    Headers Login
    ${body}=    Body User    true

    ${response}=    POST On Session    session    ${serverest.users}    json=${body}    headers=${headers}    expected_status=201

    ${id}=    Set Variable    ${response.json()['_id']}
    Should Not Be Empty    ${id}

    Should Be Equal    ${response.json()['message']}    ${messages['register_success']}

    ${response}=    GET On Session    session    ${serverest.users}/${id}    headers=${headers}

    Should Be Equal    ${response.json()['nome']}    ${name}

    Should Be Equal    ${response.json()['email']}    ${email}

    ${response}=    DELETE On Session    session    ${serverest.users}/${id}    expected_status=200

GET - Search For All Users In Database
    [Documentation]    Search on database for all users registered
    [Tags]    user

    ${id}=    POST User    false

    ${response}=    GET On Session     session    ${serverest.users}   headers=${headers}

    ${string_qnt}=    Convert To String    ${response.json()['quantidade']}
    Should Not Be Empty    ${string_qnt}
    Should Not Be Empty    ${response.json()['usuarios']}

    ${list}=    Evaluate    isinstance(${response.json()['usuarios']}, list)
    Should Be True    ${list}

    ${response}=    DELETE On Session    session    ${serverest.users}/${id}    expected_status=200

GET - Search For User Using ID
    [Documentation]    Search on database for an user by ID
    [Tags]    user

    ${id}=    POST User    false  

    ${response}=    GET On Session     session    ${serverest.users}/${id}   headers=${headers}

    Should Be Equal    ${response.json()['nome']}    ${name}

    Should Be Equal    ${response.json()['email']}    ${email}

    ${response}=    DELETE On Session    session    ${serverest.users}/${id}    expected_status=200

PUT - Create A New User When Try To Update With Non Existent ID
    [Documentation]    Use an invalid ID to update but create a new user instead
    [Tags]    user

    Faker Data
    
    ${headers}=    Headers Login    
    ${body}=    Body User    false

    ${response}=    PUT On Session    session    ${serverest.users}/${invalid_id}    json=${body}    headers=${headers}    expected_status=201

    Should Be Equal    ${response.json()['message']}    ${messages['register_success']}
    Should Not Be Empty    ${response.json()['_id']}

    ${response}=    DELETE On Session    session    ${serverest.users}/${invalid_id}   expected_status=200

PUT - Update A Previously Created User
    [Documentation]    Update administrator flag from false to true
    [Tags]    user

    Faker Data

    ${headers}=    Headers Login
    ${body}=    Body User    false

    ${response}=    POST On Session    session    ${serverest.users}    json=${body}    headers=${headers}

    ${id}=    Set Variable    ${response.json()['_id']}

    ${body2}    Set To Dictionary    ${body}    administrador=true

    ${response}=    PUT On Session    session    ${serverest.users}/${id}   json=${body}    headers=${headers}    expected_status=200

    Should Be Equal    ${response.json()['message']}    ${messages['update_success']}

    ${response}=    DELETE On Session    session    ${serverest.users}/${id}    headers=${headers}

DELETE - Delete An User Using Its ID
    [Documentation]    Delete a previously created user by its ID
    [Tags]    user
    
    ${id}=    POST User    false

    ${response}=    DELETE On Session    session    ${serverest.users}/${id}    headers=${headers}    expected_status=200

    Should Be Equal    ${response.json()['message']}    ${messages['delete_success']}