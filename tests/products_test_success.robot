*** Settings ***

Resource            ../support/resources.resource

Documentation       This suite contains all success tests of products endpoints
Metadata            Platform    API

Name                Products Endpoints Success

Suite Setup         Setup Suites

# *** Test Cases ***
# POST - Non Admin User Register Success
#     [Documentation]
