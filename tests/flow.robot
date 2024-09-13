*** Settings ***

Resource            ../support/resources.resource

Documentation       This request will login with user created on user_register.robot file
Metadata            Platform    API

Name                Complete Flow

Suite Setup    User Register    true
Suite Teardown    User Delete

*** Test Cases ***
login
    Log    ola