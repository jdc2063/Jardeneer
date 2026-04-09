*** Settings ***
Documentation    Jardeen test cases pour US 21.
Resource    jardeener.resource
Test Setup    Open Browser To Page
Suite Setup    List Suite Setup
Test Teardown    Close Browser
Suite Teardown    Clear created account

*** Variables ***
${url}    http://localhost:8084/index.html
${browser}    firefox
&{jddParcelle}    
...    name=Petit jardin  
...    address=13 Ferme Gérome    
...    cp=12216    
...    city=NewCity    
...    largeur=8    
...    longueur=8

*** Test Cases ***
Cant create parcelle Jardeener
    # Init and connection new account Jardeener
    Connection To An Account    ${jddCreateUser1}[login]     ${jddCreateUser1}[passWord]

    # On crée une parcelle
    Click Element    xpath=//*[@id="navigation"]/nav/div/ul/li[4]/a
    Wait Until Element Is Visible    //h2[.='Les parcelles...']
    Element Should Not Be Visible    id=addPlotButton

Reject parcelle Created by an Owner
    Connection To An Account    ${jddCreateUser2}[login]     ${jddCreateUser2}[passWord]

    # On crée une parcelle
    Create a parcelle    ${jddParcelle}[name]    ${jddParcelle}[address]    ${jddParcelle}[cp]    ${jddParcelle}[city]    ${jddParcelle}[largeur]    ${jddParcelle}[longueur]
    
    # On retourne sur l'admin
    Disconnect
    Connect As Admin

    # On vérifie et on refuse la parcelle
    Check and delete parcelle    ${jddParcelle}[name]  

Reject parcelle Created by an Admin
    Connect As Admin
    # On crée une parcelle
    Create a parcelle    ${jddParcelle}[name]    ${jddParcelle}[address]    ${jddParcelle}[cp]    ${jddParcelle}[city]    ${jddParcelle}[largeur]    ${jddParcelle}[longueur]

    # On vérifie et on refuse la parcelle
    Check and delete parcelle    ${jddParcelle}[name]
