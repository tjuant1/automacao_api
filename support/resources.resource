*** Settings ***

# LIBRARYS
Library    String
Library    RequestsLibrary
Library    FakerLibrary

Variables    ../utils/variables.py
Variables    ../fixtures/endpoints.yaml

Resource    ../keywords.resource
Resource    ../utils/user_register.resource

*** Variables ***

