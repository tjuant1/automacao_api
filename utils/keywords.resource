*** Settings ***

Resource    ../resources/resources.resource

*** Keywords ***
Headers Login
    ${headers}=    Create Dictionary    Content-Type=application/json

Headers Token
    [Arguments]    ${token}

    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${token}

Body Users
    [Arguments]    ${}