FROM bitnami/keycloak:25.0.4-debian-12-r0

ARG PLUGIN_VERSION
ARG THEME_VERSION

COPY reghook.jar /opt/bitnami/keycloak/providers/
COPY custom-theme.jar /opt/bitnami/keycloak/themes/
