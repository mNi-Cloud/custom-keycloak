FROM quay.io/keycloak/keycloak:latest

ARG PLUGIN_VERSION

COPY reghook.jar /opt/keycloak/providers/

USER root
RUN chown keycloak:keycloak /opt/keycloak/providers/reghook.jar
