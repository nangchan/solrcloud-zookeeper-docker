@ECHO OFF
:: lcow (linux containers on windows) has trouble stoping linux containers
:: to turn off "docker update --restart=no [container-id]"
docker update --restart=no solrcloud_solr-1_1
docker update --restart=no solrcloud_zoo-1_1
ECHO Please restart docker to stop solr/zookeeper and run .\clean.bat
