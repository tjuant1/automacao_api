*** Settings ***

Resource            ../support/resources.resource

Documentation       This suite will test user endpoints
Metadata            Platform    API

Name                User Endpoints

Suite Setup         Setup Suites
Suite Teardown

*** Test Cases ***
POST Basic User Register Success
    [Documentation]    Create a new user with valid data

    Faker Data

    ${headers}=    Headers Login
    
    ${body}=    Body User    false

    ${response}=    POST On Session    session    ${serverest.users}    json=${body}    headers=${headers}

    ${_id}=    Set Variable    ${response.json()['_id']}
    ${message}=    Set Variable    ${response.json()['message']}

    ${response}=    GET On Session    session    ${serverest.users}    headers=${headers}