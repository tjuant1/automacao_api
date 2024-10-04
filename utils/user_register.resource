*** Settings ***

Resource            ../support/resources.resource

Documentation       This request is used to create the database for every test inside serverest

*** Keywords ***
User Register
    [Documentation]    Register a new user with admin access
    [Arguments]    ${boolean_admin}

    Faker Data

    ${headers}=    Headers Login
    ${body}=    Body User    ${boolean_admin}

    Create Session    session    ${serverest.backend}
    ${response}=    POST On Session    session    ${serverest.users}    json=${body}    headers=${headers}

    ${_id}=    Set Variable    ${response.json()['_id']}
    Set Suite Variable    ${S_ID}    ${_id}

    ${body}=    Body Login

    ${response}=    POST On Session    session    ${serverest.login}    json=${body}    headers=${headers}

    ${token}    Set Variable    ${response.json()['authorization']}
    Headers Token    ${token}

User Delete
    [Documentation]    Delete a registered user from database

    ${response}=    DELETE On Session    session    ${serverest.users}/${S_ID}    headers=${headers}
    