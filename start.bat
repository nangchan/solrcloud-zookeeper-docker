@ECHO OFF
:: if solr failes to mount restart Docker
rmdir /s /q .\solrcloud\data
mkdir .\solrcloud\data\zoo-1\logs
mkdir .\solrcloud\data\zoo-1\data
mkdir .\solrcloud\data\solr-1\logs
mkdir .\solrcloud\data\solr-1\store\solr
mkdir .\solrcloud\data\solr-1\store\shared-lib

:: copys all files/folders even if empty
xcopy /s /e .\templates\solr\docker-entrypoint-initdb.d .\solrcloud\data\solr-1\docker-entrypoint-initdb.d\
xcopy /s /e .\templates\solr\ssl-keys .\solrcloud\data\solr-1\ssl-keys\
:: added configsets
xcopy /s /e .\templates\solr\configsets\sitecore_configs .\solrcloud\data\solr-1\configsets\sitecore_configs\

REM chmod -R ugo+rw ./solrcloud/data/solr-1

:: does not work on lcow (linux containers on windows)
REM docker network create solrcloud_default
:: removing --no-start will cause docker-compose to error since tty=true
docker-compose -f ./solrcloud/docker-compose.yml up --no-start
docker-compose -f ./solrcloud/docker-compose.yml start
