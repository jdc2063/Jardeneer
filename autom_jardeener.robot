*** Settings ***
Documentation    Jardeen test cases.
Resource    jardeener.resource
Test Setup    Open Browser To Page
Test Teardown    Close Browser

*** Test Cases ***
Create jardineer account
    Create an account    
    ...    ${jddCreateUser1}[login]    ${jddCreateUser1}[passWord]
    ...    ${jddCreateUser1}[firstName]    ${jddCreateUser1}[lastName]
    ...    ${jddCreateUser1}[genre]    ${jddCreateUser1}[birthDate]
    ...    ${jddCreateUser1}[adresse]    ${jddCreateUser1}[codePostal]
    ...    ${jddCreateUser1}[ville]
    ...    ${jddCreateUser1}[tel]    ${jddCreateUser1}[email]
    ...    ${jddCreateUser1}[lvl]    ${jddCreateUser1}[role]

Create owner account
    Create an account    
    ...    ${jddCreateUser2}[login]    ${jddCreateUser2}[passWord]
    ...    ${jddCreateUser2}[firstName]    ${jddCreateUser2}[lastName]
    ...    ${jddCreateUser2}[genre]    ${jddCreateUser2}[birthDate]
    ...    ${jddCreateUser2}[adresse]    ${jddCreateUser2}[codePostal]
    ...    ${jddCreateUser2}[ville]
    ...    ${jddCreateUser2}[tel]    ${jddCreateUser2}[email]
    ...    ${jddCreateUser2}[lvl]    ${jddCreateUser2}[role]

Accept an user account
    Connect As Admin
    Accept An Account   ${jddCreateUser1}[email]

Accept an owner account
    Connect As Admin
    Accept An Account   ${jddCreateUser2}[email]

Delete an account
    Connect As Admin
    Delete An Account    ${jddCreateUser1}[email]

Create, validate and delete an account
    Create an account    
    ...    ${jddCreateUser1}[login]    ${jddCreateUser1}[passWord]
    ...    ${jddCreateUser1}[firstName]    ${jddCreateUser1}[lastName]
    ...    ${jddCreateUser1}[genre]    ${jddCreateUser1}[birthDate]
    ...    ${jddCreateUser1}[adresse]    ${jddCreateUser1}[codePostal]
    ...    ${jddCreateUser1}[ville]
    ...    ${jddCreateUser1}[tel]    ${jddCreateUser1}[email]
    ...    ${jddCreateUser1}[lvl]    ${jddCreateUser1}[role]
    Connect As Admin
    Accept An Account    ${jddCreateUser1}[email]
    Disconnect
    Connection To An Account    ${jddCreateUser1}[login]    ${jddCreateUser1}[passWord]    ${jddCreateUser1}[firstName]    ${jddCreateUser1}[lastName]
    Disconnect
    Connect As Admin
    Delete An Account    ${jddCreateUser1}[email]

Refuse an account
    Create an account    
    ...    ${jddCreateUser1}[login]    ${jddCreateUser1}[passWord]
    ...    ${jddCreateUser1}[firstName]    ${jddCreateUser1}[lastName]
    ...    ${jddCreateUser1}[genre]    ${jddCreateUser1}[birthDate]
    ...    ${jddCreateUser1}[adresse]    ${jddCreateUser1}[codePostal]
    ...    ${jddCreateUser1}[ville]
    ...    ${jddCreateUser1}[tel]    ${jddCreateUser1}[email]
    ...    ${jddCreateUser1}[lvl]    ${jddCreateUser1}[role]
    Connect As Admin
    Refuse An Account    ${jddCreateUser1}[email]

Create a task
    Connect As Admin
    Create Task    
    ...    ${jddCreatTask1}[name]    
    ...    ${jddCreatTask1}[parcelle]    
    ...    ${jddCreatTask1}[peopleNb]    
    ...    ${jddCreatTask1}[start]    
    ...    ${jddCreatTask1}[end]    
    ...    ${jddCreatTask1}[descri]

Create a task no name
    Connect As Admin
    Create Task
    ...    ${jddCreatTaskNP1}[name]    
    ...    ${jddCreatTaskNP1}[parcelle]    
    ...    ${jddCreatTaskNP1}[peopleNb]    
    ...    ${jddCreatTaskNP1}[start]    
    ...    ${jddCreatTaskNP1}[end]    
    ...    ${jddCreatTaskNP1}[descri]
    Check Error Message Create Task