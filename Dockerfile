FROM sonatype/nexus3:latest
COPY ./keystore.jks /opt/sonatype/nexus/etc/ssl/
