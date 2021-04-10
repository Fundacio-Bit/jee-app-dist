# Imatge de Wildfly
Wildfly és la versió comunitaria del servidor d'aplicacions Jboss EAP. Segons la [Web oficial de Redhat] (https://access.redhat.com/solutions/21906), aquesta versió 14.0.1 correspon a la versión Jboss EAP 7.2. 

La imatge docker proveeix un servidor d'aplicacions Wildfly adaptat a l'entorn de desenvolupament del GOIB. En concret, la imatge inclou: drivers d'Oracle; drivers de PostgreSQL; connector Wildfly-Keycloak; i la mini aplicació goibusuari.  

## Creació i execució d'un contenidor  
```$ docker run -p 8080:8080 -p 9990:9990 -d goib/wildfly:14.0.1``` 

## Administració
L'usuari administrador per defecte és admin (password admin). Es pot personalitzar executant:  
```$ docker run -p 8080:8080 -p 9990:9990 -d -e ADMIN_USER=user -e ADMIN_PASSWORD=password goib/wildfly:14.0.1``` 
  
## Mapear directory deployments
Per desplegar aplicacions .war/.ear es pot fer servir la consola d'administració o crear un volume per mapear el directori del host amb el directori deployments del Wildfly. Per exemple, per mapear el directori /home/user/workspaces/aplicacio/aplicacio-ear/target del host, s'hauria d'executar:  
```$ docker run -p 8080:8080 -p 9990:9990 -d -v /home/user/workspaces/aplicacio/aplicacio-ear/target:/opt/jboss/wildfly/standalone/deployments/:rw goib/wildfly:14.0.1```  

## Aplicació goibusuari de prova
Aquesta imatge inclou la mini aplicació **/goibusuari** que mostra informació de l'usuari autenticat mitjançant un servidor Keycloak que haurà d'escoltar peticions des de l'adreça http://keycloak-goib:8180/auth i tenir configurat el realm GOIB i els clients goib-default i goib-ws.  
  
Per connectar aquesta imatge de Wildfly amb Keycloak es pot fer servir la imatge Keycloak del GOIB. Per això, és necessari:  
1. Afegir l'adreça **127.0.0.1 keycloak-goib** al fitxer de hosts (en Unix/Linux /etc/hosts; en Windows C:\Windows\System32\drivers\etc\hosts).
2. Crear el directori local on s'escanetjarà el directori de deployments.
En Unix/Linux: ```  $ mkdir /tmp/deployments && chmod 755 /tmp/deployments```  
En Windows: crear el directori C:\tmp\deployments i afegir-li permisos de lectura a tots els usuaris.
3. Copiar el fitxer goibusuari.ear (https://github.com/GovernIB/docker-imatges/blob/docker-imatges-1.0/wildfly-14.0.1/files/goibusuari.ear) dins del directori local de deployments.
4. Executar el següent fitxer **docker-compose.yml**.  

```  
version: '3.6'

services:
 keycloak:
    image: goib/keycloak:6.0.1
    container_name: "keycloak-goib"   
    environment:
     - KEYCLOAK_USER=admin
     - KEYCLOAK_PASSWORD=admin
    ports:
     - 8180:8180
    healthcheck:
      test: ["CMD", "curl", "-f", "http://keycloak-goib:8180/auth/realms/GOIB"]
      interval: 10s
      timeout: 10s
      retries: 5
 wildfly:
    image: goib/wildfly:14.0.1
    container_name: "wildfly-goib"
    environment:
     - ADMIN_USER=admin
     - ADMIN_PASSWORD=admin
    ports:
     - 8080:8080
     - 9990:9990
    volumes:
     - /tmp/deployments:/opt/jboss/wildfly/standalone/deployments
     # - C:\tmp\deployments:/opt/jboss/wildfly/standalone/deployments
    depends_on:
      - keycloak
``` 
 
Per iniciar els serveis: 
```$ docker-compose up -d``` 
 
Per aturar els serveis: 
```$ docker-compose down``` 

