*** Settings ***

Resource            ../support/resources.resource

Documentation       This suite contains all success tests of products endpoints
Metadata            Platform    API

Name                Product Endpoints Success

Suite Setup         Create User and Login    true
Suite Teardown      Delete User

*** Test Cases ***
POST - Register A New Product
    [Documentation]    Create a new product using an admin user
    [Tags]    products

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

GET - List All Products
    [Documentation]    List all registered products
    [Tags]    products

    ${id}=    Post Products

    ${response}=    GET On Session     session    ${serverest.products}    headers=${headers}    expected_status=200

    ${list}=    Evaluate    isinstance(${response.json()['produtos']}, list)
    Should Be True    ${list}

    ${quantity}=    Set Variable    ${response.json()['quantidade']}
    Should Be True    ${response.json()['quantidade']} > 1

    ${response}=    DELETE On Session    session    ${serverest.products}/${id}    headers=${headers}

GET - List Product by ID
    [Documentation]    Search in db for an specific product based on ID
    [Tags]    products

    ${id}=    Post Products

    ${response}=    GET On Session     session    ${serverest.products}/${id}    headers=${headers}    expected_status=200

    Should Be Equal                ${response.json()['nome']}           ${product_name}
    Should Be Equal As Integers    ${response.json()['preco']}          ${cable_price}
    Should Be Equal                ${response.json()['descricao']}      ${product_description}
    Should Be Equal                ${response.json()['quantidade']}     ${product_quantity}

    ${response}=    DELETE On Session    session    ${serverest.products}/${id}    headers=${headers}

DELETE - Delete Product From DB
    [Documentation]    Delete a registered product from db using its ID
    [Tags]    products

    ${id}=    Post Products

    ${response}=    DELETE On Session    session    ${serverest.products}/${id}    headers=${headers}    expected_status=200

    Should Be Equal As Strings    ${response.json()['message']}    ${messages['delete_success']}

PUT - Create A New Product When Try To Update With Non Existent ID
    [Documentation]    Use an invalid ID to update but create a new product instead
    [Tags]    products

    ${body}=    Body Products

    ${response}=    PUT On Session    session    ${serverest.products}/${invalid_id}    headers=${headers}    json=${body}    expected_status=201

    Should Be Equal As Strings    ${response.json()['message']}    ${messages['register_success']}
    ${id}=    Set Variable    ${response.json()['_id']}

    ${response}=    GET On Session    session    ${serverest.products}/${id}    headers=${headers}

    Should Be Equal                ${response.json()['nome']}           ${product_name}
    Should Be Equal As Integers    ${response.json()['preco']}          ${cable_price}
    Should Be Equal                ${response.json()['descricao']}      ${product_description}
    Should Be Equal                ${response.json()['quantidade']}     ${product_quantity}

    ${response}=    DELETE On Session    session    ${serverest.products}/${id}    headers=${headers}

PUT - Update A Previously Created Product
    [Documentation]    Update administrator flag from false to true
    [Tags]    products

    ${id}=    Post Products
    ${body}=    Body Products 2

    ${response}=    PUT On Session    session    ${serverest.products}/${id}    headers=${headers}    json=${body}    expected_status=200

    Should Be Equal As Strings    ${response.json()['message']}    ${messages['update_success']}

    ${response}=    GET On Session    session    ${serverest.products}/${id}    headers=${headers}

    Should Be Equal                ${response.json()['nome']}           ${product_name}
    Should Be Equal As Integers    ${response.json()['preco']}          ${table_price}
    Should Be Equal                ${response.json()['descricao']}      ${product_description}
    Should Be Equal                ${response.json()['quantidade']}     ${product_quantity}

    ${response}=    DELETE On Session    session    ${serverest.products}/${id}    headers=${headers}