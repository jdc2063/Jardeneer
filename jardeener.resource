*** Settings ***
Documentation    Jardeen test case resources.
Library    ExcelLibrary
Library    SeleniumLibrary

*** Variables ***
${url}    http://localhost:8085/index.html
${browser}    firefox
&{jddAdmin}    
...    user=admin
...    psd=admin
...    nom=Roberta    
...    prenom=Kirk
&{jddUser1}    
...    user=azertyui    
...    passWord=azertyui
&{jddCreateUser1}    
...    login=azertyui         passWord=azertyui    
...    firstName=James        lastName=Lesbzhez    
...    genre=MALE             birthDate=2000-01-01    
...    adresse=12 azertyui    codePostal=75057    
...    ville=Paris            tel=1327984560    
...    email=james@bzehz.sus    
...    lvl=BEGINNER           role=JARDEENER

&{jddCreateUser2}    
...    login=poiuytre         passWord=poiuytre  
...    firstName=Denis        lastName=Osu 
...    genre=FEMALE           birthDate=2000-01-01    
...    adresse=12 azertyui    codePostal=75057    
...    ville=Paris            tel=1327984560    
...    email=Denie@osu.sus    
...    lvl=CONFIRMED          role=OWNER

&{jddCreatTask1}    
...    name=Jardin d'Eden  
...    parcelle=2
...    peopleNb=3    ##min.1 max.20    
...    start=01-01-2027T12:00
...    end=02-01-2027T10:00
...    descri=C'est de la fumisterie 

&{jddCreateParcelle}    name=${null}    address=${null}    cp=${null}    city=${null}    largeur=${null}    longueur=${null}

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
    Input Text    id=addressInput    ${adresse}
    Input Text    id=zipCodeInput    ${codePostal}
    Input Text    id=cityInput    ${ville}
    Input Text    id=phoneNumberInput    ${tel}
    Input Text    id=emailInput    ${email}
    Select From List By Value    id=skillSelect    ${lvl}
    Select From List By Value    id=roleSelect    ${role}
    Click Button    id=registrationButton

Accept An Account
    [Arguments]    ${email}
    Click Element    xpath=//*[@id="navigation"]/nav/div/ul/li[5]/a
    Wait Until Page Contains    Les membres de l'association...
    Click Element    //*[@id="emailInput"][@value='${email}']/../../input[@name='validateJardeenerButton']
    Sleep    2
    Reload Page
    Sleep    2

Refuse An Account
    [Arguments]    ${email}
    Click Element    xpath=//*[@id="navigation"]/nav/div/ul/li[5]/a
    Wait Until Page Contains    Les membres de l'association...
    Click Element    //*[@id="emailInput"][@value='${email}']/../../input[@name='deleteNonValidatedJardeenerButton']
    Sleep    2
    Reload Page
    Sleep    2

Delete An Account
    [Arguments]    ${email}
    Click Element    xpath=//*[@id="navigation"]/nav/div/ul/li[5]/a
    Wait Until Page Contains    Les membres de l'association...
    Click Element    //*[@id="emailInput"][@value='${email}']/../../input[@name='deleteValidatedJardeenerButton']
    Element Should Not Be Visible    //*[@id="emailInput"][@value='${email}']

Connection To An Account 
    [arguments]    ${user}    ${psd}
    Click Element    xpath=//*[@id="navigation"]/nav/div/ul/li[3]/a
    Input Text    id=loginInput    ${user}
    Input Text    id=passwordInput    ${psd}
    Sleep    2
    Click Button    id=connectionButton
    Sleep    2

Connect As Admin
    Click Element    xpath=//*[@id="navigation"]/nav/div/ul/li[3]/a
    Input Text    id=loginInput    ${jddAdmin}[user]
    Input Text    id=passwordInput    ${jddAdmin}[psd]
    Sleep    2
    Click Button    id=connectionButton

Disconnect
    Click Element    xpath=//*[@id="navigation"]/nav/div/ul/li[6]/a
    Wait Until Element Is Enabled    //a[.="Inscription"]

Create Task
    [Arguments]    ${name}    ${parcelle}    ${peopleNb}    ${start}    ${end}    ${descri}
    Click Element    //*[@id="navigation"]/nav/div/ul/li[3]/a
    Input Text    id=nameInput    ${name}
    Select From List By Value    id=plotSelect    ${parcelle}
    Input Text    id=jardeenersNeededInput    ${peopleNb}
    Input Text    id=startTimeInput    ${start}
    Input Text    id=endTimeInput    ${end}
    Input Text    id=descriptionInput    ${descri}
    Sleep    5
    Click Button    id=addTaskButton

Create a parcelle with ${index}
    Create a parcelle    ${jddCreateParcelle}[name][${index}]    ${jddCreateParcelle}[address][${index}]    ${jddCreateParcelle}[cp][${index}]    ${jddCreateParcelle}[city][${index}]    ${jddCreateParcelle}[largeur][${index}]    ${jddCreateParcelle}[longueur][${index}]

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

Check error create parcelle
    [Arguments]    ${error}
    Element Should Be Visible    //*[@id='messageLabel']
    Element Text Should Be    //*[@id='messageLabel']      ${error}

Check parcelle
    [Arguments]    ${name}
    # Aller sur la page Parcelle
    Click Element    //span[.="Parcelles"]/..
    Wait Until Element Is Visible    //h2[.='Parcelles à valider...']
    Wait Until Element Is Enabled    //div[@id='plotsToValidate']
    
    Element Should Be Visible    //input[@id='nameInput'][@value="${name}"]
    Element Should Be Visible    //input[@id='nameInput'][@value="${name}"]/../..
    Element Attribute Value Should Be    //input[@id='nameInput'][@value="${name}"]/../../../../..    id    plotsToValidate
    Element Should Be Visible    //div[@id='plotsToValidate']/div[1]/div
    Element Should Be Visible    //div[@id='plotsToValidate']/div[1]/div/form
    Element Should Be Visible    //input[@id='nameInput'][@value="${name}"]/../../input[@name='deleteNonValidatedPlotButton']

Delete parcelle
    [Arguments]    ${name}
    # Compter le nombre de parcelle affiché à valider puis on vérifie
    ${length}    Get Element Count    //div[@id='plotsToValidate']/div
    Click Button    //input[@id='nameInput'][@value="${name}"]/../../input[@name='deleteNonValidatedPlotButton']
    Sleep    1
    ${length2}    Get Element Count    //div[@id='plotsToValidate']/div
    Should Be True    ${length}==${length2}+1
    
    Click Element    //span[.="Parcelles"]/..
    Sleep    1
    ${length2}    Get Element Count    //div[@id='plotsToValidate']/div
    Should Be True    ${length}==${length2}+1
    Element Should not Be Visible    //h3[.="${name}"]

Accepte parcelle
    [Arguments]    ${name}
    # Compter le nombre de parcelle affiché à valider puis on vérifie
    ${lengthToValidateBefore}    Get Element Count    //div[@id='plotsToValidate']/div
    ${lengthValidatedBefore}    Get Element Count    //div[@id='plots']/div
    Click Button    //h3[.="${name}"]/../input[@name='validatePlotButton']
    Sleep    1
    ${lengthToValidateAfter}    Get Element Count    //div[@id='plotsToValidate']/div
    ${lengthValidatedAfter}    Get Element Count    //div[@id='plots']/div
    Should Be True    ${lengthToValidateBefore}==${lengthToValidateAfter}+1
    Should Be True    ${lengthValidatedBefore}+1==${lengthValidatedAfter}
    
    Click Element    //span[.="Parcelles"]/..
    Sleep    1

    ${lengthToValidateAfter}    Get Element Count    //div[@id='plotsToValidate']/div
    ${lengthValidatedAfter}    Get Element Count    //div[@id='plots']/div
    Should Be True    ${lengthToValidateBefore}==${lengthToValidateAfter}+1
    Should Be True    ${lengthValidatedBefore}+1==${lengthValidatedAfter}

    Element Should not Be Visible    //h3[.="${name}"]

Check and delete parcelle ${index}
    Check and delete parcelle     ${jddCreateParcelle}[name][${index}]

Check and delete parcelle
    [Arguments]    ${name}
    Check parcelle    ${name}
    Delete Parcelle    ${name}

List Suite Setup
    Read File parcelle
    Open Browser To Page
    #Create account owner
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

    Sleep   1

    #Create account jardeener
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
    Connect As Admin
    Accept An Account    ${jddCreateUser1}[email]
    Accept An Account    ${jddCreateUser2}[email]

    Disconnect

Clear created account
    Open Browser To Page
    Connect As Admin
    # On supprime le compte créé
    Delete An Account   ${jddCreateUser1}[email]
    Delete An Account   ${jddCreateUser2}[email]
    Close Browser
    
Read File parcelle
    Open Excel Document    parcelle.xlsx    docid
    ${jddCreateParcelle}[name]    Read Excel Column    1
    ${jddCreateParcelle}[address]    Read Excel Column    2
    ${jddCreateParcelle}[cp]    Read Excel Column    3
    ${jddCreateParcelle}[city]    Read Excel Column    4
    ${jddCreateParcelle}[largeur]    Read Excel Column    5
    ${jddCreateParcelle}[longueur]    Read Excel Column    6