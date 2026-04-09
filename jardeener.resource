*** Settings ***
Documentation    Jardeen test case resources.
Library    SeleniumLibrary

*** Variables ***
${url}    http://localhost:8084/index.html
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
...    login=azertyui    
...    passWord=azertyui    
...    firstName=James    
...    lastName=Lesbzhez    
...    genre=MALE    
...    birthDate=2000-01-01    
...    adresse=12 azertyui    
...    codePostal=75057    
...    ville=Paris   
...    tel=1327984560    
...    email=james@bzehz.sus    
...    lvl=BEGINNER    
...    role=JARDEENER

&{jddCreateUser2}    
...    login=poiuytre  
...    passWord=poiuytre  
...    firstName=Denis    
...    lastName=Osu 
...    genre=FEMALE    
...    birthDate=2000-01-01    
...    adresse=12 azertyui    
...    codePostal=75057    
...    ville=Paris   
...    tel=1327984560    
...    email=Denie@osu.sus    
...    lvl=CONFIRMED    
...    role=OWNER

&{jddCreatTask1}    
...    name=Jardin d'Eden  
...    parcelle=2
...    peopleNb=3    ##min.1 max.20    
...    start=01-01-2027T12:00
...    end=02-01-2027T10:00
...    descri=C'est de la fumisterie 

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