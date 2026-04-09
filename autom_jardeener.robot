*** Settings ***
Documentation    Jardeen test cases.
Resource    jardeener.resource
Test Setup    Open Browser To Page
Test Teardown    Close Browser

*** Test Cases ***
Connect and go to my space
    Connection To An Account    ${jddUser1}[user]    ${jddUser1}[passWord]

Create jardineer account
    Create an account    
    ...    ${jddCreateUser1}[login]
    ...    ${jddCreateUser1}[passWord]
    ...    ${jddCreateUser1}[firstName]
    ...    ${jddCreateUser1}[lastName]
    ...    ${jddCreateUser1}[genre]
    ...    ${jddCreateUser1}[birthDate]
    ...    ${jddCreateUser1}[adresse]
    ...    ${jddCreateUser1}[codePostal]
    ...    ${jddCreateUser1}[ville]
    ...    ${jddCreateUser1}[tel]
    ...    ${jddCreateUser1}[email]
    ...    ${jddCreateUser1}[lvl]
    ...    ${jddCreateUser1}[role]

Create owner account
    Create an account    
    ...    ${jddCreateUser2}[login]
    ...    ${jddCreateUser2}[passWord]
    ...    ${jddCreateUser2}[firstName]
    ...    ${jddCreateUser2}[lastName]
    ...    ${jddCreateUser2}[genre]
    ...    ${jddCreateUser2}[birthDate]
    ...    ${jddCreateUser2}[adresse]
    ...    ${jddCreateUser2}[codePostal]
    ...    ${jddCreateUser2}[ville]
    ...    ${jddCreateUser2}[tel]
    ...    ${jddCreateUser2}[email]
    ...    ${jddCreateUser2}[lvl]
    ...    ${jddCreateUser2}[role]

Accept an account
    Connect As Admin
    Accept An Account   ${jddCreateUser1}[email]

Delete an account
    Connect As Admin
    Delete An Account    ${jddCreateUser1}[email]

Create, validate and delete an account
    Create an account    
    ...    ${jddCreateUser1}[login]
    ...    ${jddCreateUser1}[passWord]
    ...    ${jddCreateUser1}[firstName]
    ...    ${jddCreateUser1}[lastName]
    ...    ${jddCreateUser1}[genre]
    ...    ${jddCreateUser1}[birthDate]
    ...    ${jddCreateUser1}[adresse]
    ...    ${jddCreateUser1}[codePostal]
    ...    ${jddCreateUser1}[ville]
    ...    ${jddCreateUser1}[tel]
    ...    ${jddCreateUser1}[email]
    ...    ${jddCreateUser1}[lvl]
    ...    ${jddCreateUser1}[role]
    Connect As Admin
    Accept An Account    ${jddCreateUser1}[email]
    Disconnect
    Connection To An Account    ${jddUser1}[user]    ${jddUser1}[passWord]
    Disconnect
    Connect As Admin
    Delete An Account    ${jddCreateUser1}[email]

Refuse an account
    Create an account    
    ...    ${jddCreateUser1}[login]
    ...    ${jddCreateUser1}[passWord]
    ...    ${jddCreateUser1}[firstName]
    ...    ${jddCreateUser1}[lastName]
    ...    ${jddCreateUser1}[genre]
    ...    ${jddCreateUser1}[birthDate]
    ...    ${jddCreateUser1}[adresse]
    ...    ${jddCreateUser1}[codePostal]
    ...    ${jddCreateUser1}[ville]
    ...    ${jddCreateUser1}[tel]
    ...    ${jddCreateUser1}[email]
    ...    ${jddCreateUser1}[lvl]
    ...    ${jddCreateUser1}[role]
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