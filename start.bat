@ECHO OFF
:: if solr failes to mount restart Docker
rmdir /s /q .\solrcloud\data
mkdir .\solrcloud\data\zoo-1\logs
mkdir .\solrcloud\data\zoo-1\data
mkdir .\solrcloud\data\solr-1\logs
mkdir .\solrcloud\data\solr-1\store\solr
mkdir .\solrcloud\data\solr-1\store\shared-lib
xcopy .\templates\solr\docker-entrypoint-initdb.d .\solrcloud\data\solr-1\docker-entrypoint-initdb.d\
xcopy .\templates\solr\ssl-keys .\solrcloud\data\solr-1\ssl-keys\

REM chmod -R ugo+rw ./solrcloud/data/solr-1

:: does not work on lcow (linux containers on windows)
REM docker network create solrcloud_default
docker-compose -f ./solrcloud/docker-compose.yml up --no-start
docker-compose -f ./solrcloud/docker-compose.yml start
