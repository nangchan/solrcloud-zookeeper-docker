rm solr-ssl.*
# change the DNS from nchan-mbp-2016.local to your own eg. localhost
keytool -genkeypair -alias solr-ssl -keyalg RSA -keysize 2048 -keypass secret -storepass secret -validity 9999 -keystore solr-ssl.keystore.jks -ext SAN=DNS:docker-host.local,DNS:solr-1,IP:10.211.55.2,IP:127.0.0.1 -dname "CN=docker-host.local, OU=Infrastructure, O=Boingo Wireless, L=Los Angeles, ST=California, C=US"
# convert JKS to PKCS12 - enter secret for password
keytool -importkeystore -srckeystore solr-ssl.keystore.jks -destkeystore solr-ssl.keystore.p12 -srcstoretype jks -deststoretype pkcs12 -srcstorepass secret -deststorepass secret
# convert PKCS12 to PEM
openssl pkcs12 -in solr-ssl.keystore.p12 -out solr-ssl.pem -passin pass:secret -passout pass:secret
# create cert-only version of PEM
openssl pkcs12 -nokeys -in solr-ssl.keystore.p12 -out solr-ssl.cacert.pem -passin pass:secret
