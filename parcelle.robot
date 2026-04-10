*** Settings ***
Documentation    Jardeen test cases pour US 21.
Resource    jardeener.resource
Test Setup    Open Browser To Page
Suite Setup    List Suite Setup
Test Teardown    Close Browser
Suite Teardown    Clear created account

*** Test Cases ***
#TODO Ajouter Admin + zip code with letter + Nombre négatif pour largeur/longueur qui n'est pas logique
#TODO Erreur message d'erreur hectar < 20 m2
# Reject parcelle Created by an Admin - Classic
#     VAR    ${index}  0
#     Connect As Admin
#     # On crée une parcelle
#     Create a parcelle with ${index}

#     # On vérifie et on refuse la parcelle
#     Check and delete parcelle ${index}
#=======================#

Cant create parcelle Jardeener
    # Init and connection new account Jardeener
    Connection To An Account    ${jddCreateUser1}[login]     ${jddCreateUser1}[passWord]

    # On crée une parcelle
    Click Element    xpath=//*[@id="navigation"]/nav/div/ul/li[4]/a
    Wait Until Element Is Visible    //h2[.='Les parcelles...']
    Element Should Not Be Visible    id=addPlotButton

Reject parcelle Created by an Owner - Classic
    VAR    ${index}  0
    Connection To An Account    ${jddCreateUser2}[login]     ${jddCreateUser2}[passWord]

    # On crée une parcelle
    Create a parcelle with ${index}

    # On retourne sur l'admin
    Disconnect
    Connect As Admin

    # On vérifie et on refuse la parcelle
    Check and delete parcelle ${index}

Reject parcelle Created by an Owner - 2A zip code
    VAR    ${index}  1
    Connection To An Account    ${jddCreateUser2}[login]     ${jddCreateUser2}[passWord]

    # On crée une parcelle
    Create a parcelle with ${index}

    # On retourne sur l'admin
    Disconnect
    Connect As Admin

    # On vérifie et on refuse la parcelle
    Check and delete parcelle ${index}

Reject parcelle Created by an Owner - 2B zip code
    VAR    ${index}  2
    Connection To An Account    ${jddCreateUser2}[login]     ${jddCreateUser2}[passWord]

    # On crée une parcelle
    Create a parcelle with ${index}

    # On retourne sur l'admin
    Disconnect
    Connect As Admin

    # On vérifie et on refuse la parcelle
    Check and delete parcelle ${index}

Reject parcelle Created by an Owner - Decimal largeur
    VAR    ${index}  3
    Connection To An Account    ${jddCreateUser2}[login]     ${jddCreateUser2}[passWord]

    # On crée une parcelle
    Create a parcelle with ${index}

    # On retourne sur l'admin
    Disconnect
    Connect As Admin

    # On vérifie et on refuse la parcelle
    Check and delete parcelle ${index}

Reject parcelle Created by an Owner - Decimal longueur
    VAR    ${index}  4
    Connection To An Account    ${jddCreateUser2}[login]     ${jddCreateUser2}[passWord]

    # On crée une parcelle
    Create a parcelle with ${index}

    # On retourne sur l'admin
    Disconnect
    Connect As Admin

    # On vérifie et on refuse la parcelle
    Check and delete parcelle ${index}

Reject parcelle Created by an Owner - Decimal largeur and longueur
    VAR    ${index}  5
    Connection To An Account    ${jddCreateUser2}[login]     ${jddCreateUser2}[passWord]

    # On crée une parcelle
    Create a parcelle with ${index}

    # On retourne sur l'admin
    Disconnect
    Connect As Admin

    # On vérifie et on refuse la parcelle
    Check and delete parcelle ${index}

Validate parcelle Created by an Owner - Classic
    VAR    ${index}  0
    Connection To An Account    ${jddCreateUser2}[login]     ${jddCreateUser2}[passWord]

    # On crée une parcelle
    Create a parcelle with ${index}

    # On retourne sur l'admin
    Disconnect
    Connect As Admin

    # On vérifie et on accepte la parcelle
    Check parcelle    ${jddCreateParcelle}[name][${index}]
    Sleep    1
    Accepte parcelle    ${jddCreateParcelle}[name][${index}]
    Sleep    1

Cant create parcelle with name already used
    VAR    ${index}  0
    Connection To An Account    ${jddCreateUser2}[login]     ${jddCreateUser2}[passWord]

    # On crée une parcelle
    Create a parcelle with ${index}

    # On crée une parcelle
    Create a parcelle with ${index}
    Sleep    2
    Check error create parcelle    Une parcelle existe déjà avec le nom "${jddCreateParcelle}[name][${index}]".


    # On retourne sur l'admin
    Disconnect
    Connect As Admin

    # On vérifie et on refuse la parcelle
    Check and delete parcelle ${index}

Cant create parcelle with no name
    VAR    ${index}  6
    Connection To An Account    ${jddCreateUser2}[login]     ${jddCreateUser2}[passWord]

    # On crée une parcelle
    Create a parcelle with ${index}

    Check error create parcelle    Vous devez renseigner tous les champs.


Cant create parcelle with no address
    VAR    ${index}  7
    Connection To An Account    ${jddCreateUser2}[login]     ${jddCreateUser2}[passWord]

    # On crée une parcelle
    Create a parcelle with ${index}

    Check error create parcelle    Vous devez renseigner tous les champs.

Cant create parcelle with no zip code
    VAR    ${index}  8
    Connection To An Account    ${jddCreateUser2}[login]     ${jddCreateUser2}[passWord]

    # On crée une parcelle
    Create a parcelle with ${index}

    Check error create parcelle    Vous devez renseigner tous les champs.

Cant create parcelle with no city
    VAR    ${index}  9
    Connection To An Account    ${jddCreateUser2}[login]     ${jddCreateUser2}[passWord]

    # On crée une parcelle
    Create a parcelle with ${index}

    Check error create parcelle    Vous devez renseigner tous les champs.

Cant create parcelle with no Largeur
    VAR    ${index}  10
    Connection To An Account    ${jddCreateUser2}[login]     ${jddCreateUser2}[passWord]

    # On crée une parcelle
    Create a parcelle with ${index}

    Check error create parcelle    Vous devez renseigner tous les champs.

Cant create parcelle with no Longueur
    VAR    ${index}  11
    Connection To An Account    ${jddCreateUser2}[login]     ${jddCreateUser2}[passWord]

    # On crée une parcelle
    Create a parcelle with ${index}

    Check error create parcelle    Vous devez renseigner tous les champs.

# Cant create parcelle with zip code only letter
#     VAR    ${index}  12
#     Connection To An Account    ${jddCreateUser2}[login]     ${jddCreateUser2}[passWord]

#     # On crée une parcelle
#     Create a parcelle with ${index}

#     Check error create parcelle    Vous devez renseigner tous les champs.

Cant create parcelle with code zip >5 char
    VAR    ${index}  13
    Connection To An Account    ${jddCreateUser2}[login]     ${jddCreateUser2}[passWord]

    # On crée une parcelle
    Create a parcelle with ${index}

    Check error create parcelle   Le code postal doit être composé de 5 caractères (chiffres et lettres majuscules)

Cant create parcelle with code zip <5 char
    VAR    ${index}  14
    Connection To An Account    ${jddCreateUser2}[login]     ${jddCreateUser2}[passWord]

    # On crée une parcelle
    Create a parcelle with ${index}

    Check error create parcelle    Le code postal doit être composé de 5 caractères (chiffres et lettres majuscules)

# Cant create parcelle with negative Longueur
#     VAR    ${index}  15
#     Connection To An Account    ${jddCreateUser2}[login]     ${jddCreateUser2}[passWord]

#     # On crée une parcelle
#     Create a parcelle with ${index}

#     Check error create parcelle    Vous devez renseigner tous les champs.

Cant create parcelle with letter Longueur
    VAR    ${index}  16
    Connection To An Account    ${jddCreateUser2}[login]     ${jddCreateUser2}[passWord]

    # On crée une parcelle
    Create a parcelle with ${index}

    Check error create parcelle    Vous devez renseigner tous les champs.

# Cant create parcelle with negative Largeur
#     VAR    ${index}  17
#     Connection To An Account    ${jddCreateUser2}[login]     ${jddCreateUser2}[passWord]

#     # On crée une parcelle
#     Create a parcelle with ${index}

#     Check error create parcelle    Vous devez renseigner tous les champs.

Cant create parcelle with letter Largeur
    VAR    ${index}  18
    Connection To An Account    ${jddCreateUser2}[login]     ${jddCreateUser2}[passWord]

    # On crée une parcelle
    Create a parcelle with ${index}

    Check error create parcelle    Vous devez renseigner tous les champs.

# Cant create parcelle with negative Largeur Longueur
#     VAR    ${index}  19
#     Connection To An Account    ${jddCreateUser2}[login]     ${jddCreateUser2}[passWord]

#     # On crée une parcelle
#     Create a parcelle with ${index}

#     Check error create parcelle    Vous devez renseigner tous les champs.

# Cant create parcelle with only 0 in zip code
#     VAR    ${index}  20
#     Connection To An Account    ${jddCreateUser2}[login]     ${jddCreateUser2}[passWord]

#     # On crée une parcelle
#     Create a parcelle with ${index}

#     Check error create parcelle    Vous devez renseigner tous les champs.

# Cant create parcelle with >1 letter in zip code
#     VAR    ${index}  21
#     Connection To An Account    ${jddCreateUser2}[login]     ${jddCreateUser2}[passWord]

#     # On crée une parcelle
#     Create a parcelle with ${index}

#     Check error create parcelle    Vous devez renseigner tous les champs.

# Cant create parcelle with 1 letter but not 2A or 2B in zip code
#     VAR    ${index}  22
#     Connection To An Account    ${jddCreateUser2}[login]     ${jddCreateUser2}[passWord]

#     # On crée une parcelle
#     Create a parcelle with ${index}

#     Check error create parcelle    Vous devez renseigner tous les champs.

Cant create parcelle with 19 hectar
    VAR    ${index}  23
    Connection To An Account    ${jddCreateUser2}[login]     ${jddCreateUser2}[passWord]

    # On crée une parcelle
    Create a parcelle with ${index}

    Check error create parcelle    La parcelle doit faire minimum 20m².

Cant create parcelle with 18 hectar
    VAR    ${index}  24
    Connection To An Account    ${jddCreateUser2}[login]     ${jddCreateUser2}[passWord]

    # On crée une parcelle
    Create a parcelle with ${index}

    Check error create parcelle    La parcelle doit faire minimum 20m².