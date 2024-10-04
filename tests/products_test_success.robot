*** Settings ***

Resource            ../support/resources.resource

Documentation       This suite contains all success tests of products endpoints
Metadata            Platform    API

Name                Products Endpoints Success

Suite Setup         Create User and Login    true

*** Test Cases ***
POST - Register A New Product
    [Documentation]    Create a new product using an admin uer
    [Tags]    products

    Create Product Variable

    ${headers}=    Headers Token    ${token}
    ${body}=    Body Products
