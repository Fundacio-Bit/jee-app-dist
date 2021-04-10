#############################################################################################
# Keycloak 6.0.1 adaptado al entorno de desarrollo del Govern de les Illes Balears (GOIB)
#
# Comando para construir la imagen: 
# docker build -t goib/keycloak:6.0.1 .
#
# Comando para crear y ejecutar un contenedor: 
# docker run -p 8180:8180 goib/keycloak:6.0.1
#
# Expone el puerto 8180
#
# Incluye: el realm GOIB; los clientes goib-default y goib-ws; el rol EBO_SUPERVISOR a nivel
# de realm y clientes; el usuario u999000 con password u999000 para autenticación goib-default;
# y el usuario $GOIB_USUARI con password $GOIB_USUARI para autenticación goib-ws
#
#############################################################################################

FROM jboss/keycloak:6.0.1

LABEL MAINTAINER="Govern de les Illes Balears <suport@caib.es>"
ENV KEYCLOAK_USER=admin \
    KEYCLOAK_PASSWORD=admin \
    KEYCLOAK_IMPORT=/tmp/import-goib-realm.json

WORKDIR /opt/jboss/

COPY ./keycloak/conf/import-goib-realm.json /tmp

USER jboss

EXPOSE 8180

CMD ["-b 0.0.0.0 -bmanagement 0.0.0.0 -Djboss.socket.binding.port-offset=100"]
