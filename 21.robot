*** Settings ***
Documentation    Jardeen test cases pour US 21.
Library    SeleniumLibrary
Test Setup    Open Browser To Page
Test Teardown    Close Browser

*** Variables ***
${url}    http://localhost:8083/index.html
${browser}    firefox
&{jddLog1}    
...    user=admin
...    psd=admin
&{jddUser1}    
...    nom=Roberta    
...    prenom=Kirk
&{jddCreateUser1}    
...    login=azertyui         passWord=azertyui    
...    firstName=James        lastName=Lesbzhez    
...    genre=MALE             birthDate=2000-01-01    
...    adresse=12 azertyui    codePostal=75057    
...    ville=Paris            tel=1327984560    
...    email=james@bzehz.sus    
...    lvl=BEGINNER           role=OWNER

&{jddCreateUser2}   
...    login=Jardeener         passWord=Jardeener    
...    firstName=Jardeener        lastName=Jardeener    
...    genre=MALE             birthDate=1999-12-12   
...    adresse=209 Rue de la ferme    codePostal=75057    
...    ville=Paris            tel=1327984560    
...    email=Jardeener@pksb.sus    
...    lvl=CONFIRMED           role=JARDEENER 

&{jddParcelle}    
...    name=Ferme Gérome    
...    address=13 Ferme Gérome    
...    cp=12216    
...    city=NewCity    
...    largeur=8    
...    longueur=8

*** Keywords ***
Open Browser To Page
    Open Browser    ${url}    ${browser}
    Maximize Browser Window

Create an account
    [Arguments]    ${login}    ${passWord}    ${firstName}    ${lastName}    ${genre}    ${birthDate}    ${adresse}    ${codePostal}    ${ville}    ${tel}    ${email}    ${lvl}    ${role}
    Click Element    xpath=//*[@id="navigation"]/nav/div/ul/li[2]/a
    Wait Until Element Is Visible    id=registrationButton
    Input Text    id=loginInput    ${login}
    Input Text    id=passwordInput    ${passWord}
    Input Text    id=firstNameInput    ${firstName}
    Input Text    id=lastNameInput    ${lastName}
    sleep    2
    Select From List By Value    id=genderSelect    ${genre}
    Input Text    id=birthdateInput    ${birthDate}
    Sleep    2
    Input Text    id=addressInput    ${adresse}
    Input Text    id=zipCodeInput    ${codePostal}
    Input Text    id=cityInput    ${ville}
    Input Text    id=phoneNumberInput    ${tel}
    Input Text    id=emailInput    ${email}
    Select From List By Value    id=skillSelect    ${lvl}
    Select From List By Value    id=roleSelect    ${role}
    Sleep    2
    Click Button    id=registrationButton
    Sleep    2

Accept registration
    [arguments]    ${email}
    Sleep    2
    ##Textfield Value Should Be    id=firstNameInput    ${jddCreateUser1}[firstName]
    Click Element    xpath=//*[@id="navigation"]/nav/div/ul/li[5]/a
    Wait Until Page Contains    Les membres de l'association...
    Sleep    2
    Click Element    //*[@id="emailInput"][@value='${email}']/../../input[@name='validateJardeenerButton']

Connection To An Account 
    [arguments]    ${user}    ${psd}    ${nom}    ${prenom}
    Click Element    xpath=//*[@id="navigation"]/nav/div/ul/li[3]/a
    Input Text    id=loginInput    ${user}
    Input Text    id=passwordInput    ${psd}
    Sleep    2
    Click Button    id=connectionButton
    Wait Until Element Contains    //*[@id="navigation"]/nav/div/label    text=${nom} ${prenom}

Disconnect
    Click Element    //a[@onclick='disconnect()']
    Sleep    1

Init and connection new account Owner
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
    Sleep    1
    Connection To An Account    ${jddLog1}[user]    ${jddLog1}[psd]    ${jddUser1}[nom]    ${jddUser1}[prenom]
    Accept registration    ${jddCreateUser1}[email]
    Switch account    ${jddCreateUser1}[login]     ${jddCreateUser1}[passWord]    ${jddCreateUser1}[firstName]    ${jddCreateUser1}[lastName]

Init and connection new account Jardeener
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
    Sleep    1
    Connection To An Account    ${jddLog1}[user]    ${jddLog1}[psd]    ${jddUser1}[nom]    ${jddUser1}[prenom]
    Accept registration    ${jddCreateUser1}[email]
    Switch account    ${jddCreateUser2}[login]     ${jddCreateUser2}[passWord]    ${jddCreateUser2}[firstName]    ${jddCreateUser2}[lastName]

Switch account 
    [arguments]    ${user}    ${psd}    ${nom}    ${prenom}
    Disconnect
    Connection To An Account    ${user}    ${psd}    ${nom}    ${prenom}

Create a parcelle
    [Arguments]    ${name}    ${address}    ${cp}    ${city}    ${largeur}    ${longueur}
    Click Element    xpath=//*[@id="navigation"]/nav/div/ul/li[4]/a
    Wait Until Element Is Visible    id=addPlotButton
    Input Text    id=nameInput    ${name}
    Input Text    id=addressInput    ${address}
    Input Text    id=zipCodeInput    ${cp}
    Sleep    2
    Input Text    id=cityInput    ${city}
    Input Text    id=widthInput    ${largeur}
    Input Text    id=lengthInput    ${longueur}
    Sleep    2
    Click Button    id=addPlotButton
    Sleep    2

Delete An Account
    [Arguments]    ${email}
    # Cliquer sur le bouton de navigation "Membres"
    Click Element    xpath=//*[@id="navigation"]/nav/div/ul/li[5]/a
    Wait Until Page Contains    Les membres de l'association...

    # Cliquer sur le bouton supprimer de l'utilisateur créer au début du test
    Click Element    //*[@id="emailInput"][@value='${email}']/../../input[@name='deleteValidatedJardeenerButton']

Check parcelle
    # Aller sur la page Parcelle
    Click Element    //span[.="Parcelles"]/..
    Sleep    1
    Wait Until Element Is Visible    //h2[.='Parcelles à valider...']
    Wait Until Element Is Enabled    //div[@id='plotsToValidate']
    
    Element Should Be Visible    //h3[.="${jddParcelle}[name]"]
    Element Should Be Visible    //h3[.="${jddParcelle}[name]"]/../..
    Element Attribute Value Should Be    //h3[.="${jddParcelle}[name]"]/../../../..    id    plotsToValidate
    Element Should Be Visible    //div[@id='plotsToValidate']/div[1]/div
    Element Should Be Visible    //div[@id='plotsToValidate']/div[1]/div/form
    Element Should Be Visible    //div[@id='plotsToValidate']/div[1]/div/form/h3
    Element Should Be Visible    //h3[.="${jddParcelle}[name]"]/../input[@name='deleteNonValidatedPlotButton']

Delete parcelle
    # Compter le nombre de parcelle affiché à valider puis on vérifie
    ${length}    Get Element Count    //div[@id='plotsToValidate']/div
    Click Button    //h3[.="${jddParcelle}[name]"]/../input[@name='deleteNonValidatedPlotButton']
    Sleep    1
    ${length2}    Get Element Count    //div[@id='plotsToValidate']/div
    Should Be True    ${length}==${length2}+1
    
    Click Element    //span[.="Parcelles"]/..
    Sleep    1
    ${length2}    Get Element Count    //div[@id='plotsToValidate']/div
    Should Be True    ${length}==${length2}+1
    Element Should not Be Visible    //h3[.="${jddParcelle}[name]"]

Check and delete parcelle
    Check parcelle
    Delete Parcelle

*** Test Cases ***
Reject parcelle Created by an Owner
    # On crée et on s'authentifie sur un nouveau profil
    Init and connection new account Owner

    # On crée une parcelle
    Create a parcelle    ${jddParcelle}[name]    ${jddParcelle}[address]    ${jddParcelle}[cp]    ${jddParcelle}[city]    ${jddParcelle}[largeur]    ${jddParcelle}[longueur]
    
    # On retourne sur l'admin
    Switch account    ${jddLog1}[user]    ${jddLog1}[psd]    ${jddUser1}[nom]    ${jddUser1}[prenom]

    # On vérifie et on refuse la parcelle
    Check and delete parcelle
    
    # On supprime le compte créé
    Delete An Account   ${jddCreateUser1}[email]

Reject parcelle Created by an Jardeener
    # On crée et on s'authentifie sur un nouveau profil
    Init and connection new account Jardeener
    # Init and connection new account Jardeener

    # On crée une parcelle
    Create a parcelle    ${jddParcelle}[name]    ${jddParcelle}[address]    ${jddParcelle}[cp]    ${jddParcelle}[city]    ${jddParcelle}[largeur]    ${jddParcelle}[longueur]
    
    # On retourne sur l'admin
    Switch account    ${jddLog1}[user]    ${jddLog1}[psd]    ${jddUser1}[nom]    ${jddUser1}[prenom]

    # On vérifie et on refuse la parcelle
    Check and delete parcelle
    
    # On supprime le compte créé
    Delete An Account   ${jddCreateUser2}[email]

# Create New Account
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