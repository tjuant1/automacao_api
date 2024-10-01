*** Settings ***

Resource            ../support/resources.resource

Documentation       This suite contains all tests of users endpoints but testing business rules
Metadata            Platform    API

Name                User Endpoints Exceptions

Suite Setup         Setup Suites
Suite Teardown

# *** Test Cases ***
# POST - Non Admin User Register Success
#     [Documentation]    
    
    