FROM bitnami/keycloak:25.0.4-debian-12-r0 as builder

ARG PLUGIN_VERSION
ARG THEME_VERSION

COPY reghook.jar /opt/keycloak/providers/
COPY custom-theme.jar /opt/keycloak/providers/

RUN /opt/keycloak/bin/kc.sh build

FROM bitnami/keycloak:25.0.4-debian-12-r0

COPY --from=builder /opt/keycloak/ /opt/keycloak/

USER root
RUN chown -R keycloak:keycloak /opt/keycloak/providers/ && \
    chown -R keycloak:keycloak /opt/keycloak/lib/quarkus/ && \
    chown -R keycloak:keycloak /opt/keycloak/themes/
USER keycloak

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start"]
