FROM bitnami/keycloak:25.0.4-debian-12-r0 as builder

ARG PLUGIN_VERSION
ARG THEME_VERSION

COPY reghook.jar /opt/bitnami/keycloak/providers/
COPY custom-theme.jar /opt/bitnami/keycloak/providers/

RUN /opt/bitnami/keycloak/bin/kc.sh build

FROM bitnami/keycloak:25.0.4-debian-12-r0

COPY --from=builder /opt/bitnami/keycloak/ /opt/bitnami/keycloak/

USER root
RUN chown -R 1001:1001 /opt/bitnami/keycloak/providers/ && \
    chown -R 1001:1001 /opt/bitnami/keycloak/lib/quarkus/ && \
    chown -R 1001:1001 /opt/bitnami/keycloak/themes/

USER 1001

ENTRYPOINT ["/opt/bitnami/keycloak/bin/kc.sh", "start"]
