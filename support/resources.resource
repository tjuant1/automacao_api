*** Settings ***

# LIBRARYS
Library    String
Library    RequestsLibrary
Library    FakerLibrary
Library    Collections
Library    OperatingSystem
Library    configs.py

Variables    ../utils/variables.py
Variables    ../fixtures/endpoints.yaml
Variables    ../fixtures/messages.yaml

Resource    ../keywords.resource
Resource    ../utils/user_register.resource

*** Variables ***

