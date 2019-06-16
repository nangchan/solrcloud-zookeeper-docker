REM rmdir /s /q .\solrcloud\data
REM mkdir .\solrcloud\data\zoo-1\logs
REM mkdir .\solrcloud\data\zoo-1\data
REM mkdir .\solrcloud\data\solr-1\logs
REM mkdir .\solrcloud\data\solr-1\store\solr
REM mkdir .\solrcloud\data\solr-1\store\shared-lib
REM xcopy .\templates\solr\docker-entrypoint-initdb.d .\solrcloud\data\solr-1\docker-entrypoint-initdb.d\
REM xcopy .\templates\solr\ssl-keys .\solrcloud\data\solr-1\ssl-keys\

REM chmod -R ugo+rw ./solrcloud/data/solr-1

REM docker network create solrcloud_default
docker-compose -f ./solrcloud/docker-compose.yml up --no-start
docker-compose -f ./solrcloud/docker-compose.yml start

REM docker-compose -f ./solrcloud/docker-compose.yml down
