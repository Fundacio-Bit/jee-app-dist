# Imatge de Keycloak  
Keycloak és un producte de programari de codi obert que permet l'inici de sessió únic (IdP) amb Identity Management i Access Management. La imatge docker proveeix un servidor de keycloak adaptat a l'entorn de desenvolupament del GOIB. En concret, la imatge inclou: el realm GOIB; els clients goib-default i goib-ws; el rol EBO_SUPERVISOR a nivell de clients; l'usuari u999000 (password u999000) en el client goib-default; i l'usuari d'aplicació $GOIB_USUARI (password $GOIB_USUARI) en el client goib-ws.  

## Creació i execució d'un contenidor  
    $ docker run -p 8180:8180 -d goib/keycloak:6.0.1  

## Administració
L'usuari administrador per defecte és admin (password admin). Es pot personalitzar executant:  
    $ docker run -p 8180:8180 -d -e KEYCLOAK_USER=user -e KEYCLOAK_PASSWORD=password goib/keycloak:6.0.1

