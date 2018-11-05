# Nexus 3 as Docker registry
[Using Self-Signed Certificates with Nexus Repository Manager and Docker Daemon](https://support.sonatype.com/hc/en-us/articles/217542177).

```bash
$ cd ~
$ export NEXUS_DOMAIN=hela
$ export NEXUS_IP_ADDRESS=192.168.1.101
$ keytool -genkeypair -keystore keystore.jks -storepass password -keypass password -alias jetty -keyalg RSA -keysize 2048 -validity 5000 -dname "CN=*.${NEXUS_DOMAIN}, OU=Example, O=Sonatype, L=Unspecified, ST=Unspecified, C=US" -ext "SAN=DNS:${NEXUS_DOMAIN},IP:${NEXUS_IP_ADDRESS}" -ext "BC=ca:true"

$ ls -lah ./keystore.jks 
$ mkdir nexus-build
$ mv keystore.jks ./nexus-build/
$ cd nexus-build/
$ vi Dockerfile
$ cat Dockerfile 
$ docker build -t hela/nexus3:1.0.0 .

$ cd ..
$ sudo vi ./nexus-data/etc/nexus.properties 
$ docker run -d -p 8081:8081 -p 9443:9443 --name nexus -v "$(pwd)"/nexus-data:/nexus-data hela/nexus3:1.0.0
$ export SSL_PORT=9443
$ echo $SSL_PORT
$ keytool -printcert -sslserver ${NEXUS_DOMAIN}:${SSL_PORT} -rfc > nexus-build/hela.crt
$ cat nexus-build/hela.crt 
$ sudo cp nexus-build/hela.crt /usr/local/share/ca-certificates/
$ docker login -u rwibawa -p secr3t! https://hela:9443

$ curl -X GET 'https://hela:9443'
```

