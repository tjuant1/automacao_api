*** Settings ***

Resource            ../support/resources.resource

Documentation       This suite contains all success tests of products endpoints
Metadata            Platform    API

Name                Product Endpoints Success

Suite Setup         Create User and Login    true

*** Test Cases ***
POST - Register A New Product
    [Documentation]    Create a new product using an admin user
    [Tags]    products

    Create Product Variable

    ${headers}=    Headers Token    ${token}
    ${body}=    Body Products

    ${response}=    POST On Session    session    ${serverest.products}    json=${body}    headers=${headers}    expected_status=201
    
    Should Be Equal    ${response.json()['message']}    ${messages.register_success}
    ${id}=    Set Variable    ${response.json()['_id']}
    Should Not Be Empty    ${id}

    ${response}=    GET On Session    session    ${serverest.products}/${id}    headers=${headers}    expected_status=200

    Should Be Equal                ${response.json()['nome']}           ${product_name}
    Should Be Equal As Integers    ${response.json()['preco']}          ${cable_price}
    Should Be Equal                ${response.json()['descricao']}      ${product_description}
    Should Be Equal                ${response.json()['quantidade']}     ${product_quantity}

    ${response}=    DELETE On Session    session    ${serverest.products}/${id}    headers=${headers}