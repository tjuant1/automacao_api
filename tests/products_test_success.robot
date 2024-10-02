*** Settings ***

Resource            ../support/resources.resource

Documentation       This suite contains all success tests of products endpoints
Metadata            Platform    API

Name                Products Endpoints Success

Suite Setup         Setup Suites

*** Test Cases ***
POST - Register A New Product
    [Documentation]

    @{product_values}    Evaluate    [['Cable', 'Table', 'Water'], ['1m flexible cable', '1x1m wooden table', 'really fresh water'], 
    ...    {'price_cable': '10'}, {'price_table': '150'}, {'price_water': '2'}]


