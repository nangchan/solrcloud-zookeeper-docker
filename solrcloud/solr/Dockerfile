# TO run manually
# docker exec -it solrcloud_solr-1_1 bash

# Verify that zoo-1 can be reached
# ping solr-1 && ping zoo-1
# su solr -c bash

# Afterwards commit container to image
#docker commit --message "Turn on SSL for Zookeeper and created indexes for Sitecore 9 (unpopulated)" solrcloud_solr-1_1 solrcloud_solr
#docker commit --message "Turn on SSL for Zookeeper and created indexes for Sitecore 9 (unpopulated)" solrcloud_zoo-1_1 solrcloud_zoo

# NOTE: COPY only works inside the folder containing the Dockerfile
#       https://docker-host.local:8081/solr/

FROM solr:7.2

COPY sitecore_configs /opt/solr/server/solr/configsets/sitecore_configs
COPY ssl-keys /opt/ssl-keys
COPY docker-entrypoint-initdb.d /docker-entrypoint-initdb.d

RUN mkdir /opt/logs
RUN mkdir /store
RUN mkdir /store/solr
RUN mkdir /store/shared-lib

RUN chown -R solr:solr /store
RUN chown -R solr:solr /opt/logs

# Enable HTTPS
#RUN /opt/solr/server/scripts/cloud-scripts/zkcli.sh -z zoo-1:2181 -cmd clusterprop -name urlScheme -val https
# Create cofnigset sitecore_configs
#RUN /opt/solr/server/scripts/cloud-scripts/zkcli.sh -z zoo-1:2181 -cmd upconfig -confdir /opt/solr/server/solr/configsets/sitecore_configs/conf -confname sitecore_configs

# Create Sitecore 9 indexes
#RUN /opt/solr/bin/solr create -c Sitecore9_core_index                   -d /opt/solr/server/solr/configsets/sitecore_configs/conf -n sitecore_configs -shards 1 -replicationFactor 1
#RUN /opt/solr/bin/solr create -c Sitecore9_master_index                 -d /opt/solr/server/solr/configsets/sitecore_configs/conf -n sitecore_configs -shards 1 -replicationFactor 1
#RUN /opt/solr/bin/solr create -c Sitecore9_web_index                    -d /opt/solr/server/solr/configsets/sitecore_configs/conf -n sitecore_configs -shards 1 -replicationFactor 1
#RUN /opt/solr/bin/solr create -c Sitecore9_marketingdefinitions_master  -d /opt/solr/server/solr/configsets/sitecore_configs/conf -n sitecore_configs -shards 1 -replicationFactor 1
#RUN /opt/solr/bin/solr create -c Sitecore9_marketingdefinitions_web     -d /opt/solr/server/solr/configsets/sitecore_configs/conf -n sitecore_configs -shards 1 -replicationFactor 1
#RUN /opt/solr/bin/solr create -c Sitecore9_marketing_asset_index_master -d /opt/solr/server/solr/configsets/sitecore_configs/conf -n sitecore_configs -shards 1 -replicationFactor 1
#RUN /opt/solr/bin/solr create -c Sitecore9_marketing_asset_index_web    -d /opt/solr/server/solr/configsets/sitecore_configs/conf -n sitecore_configs -shards 1 -replicationFactor 1
#RUN /opt/solr/bin/solr create -c Sitecore9_testing_index                -d /opt/solr/server/solr/configsets/sitecore_configs/conf -n sitecore_configs -shards 1 -replicationFactor 1
#RUN /opt/solr/bin/solr create -c Sitecore9_suggested_test_index         -d /opt/solr/server/solr/configsets/sitecore_configs/conf -n sitecore_configs -shards 1 -replicationFactor 1
#RUN /opt/solr/bin/solr create -c Sitecore9_fxm_master_index             -d /opt/solr/server/solr/configsets/sitecore_configs/conf -n sitecore_configs -shards 1 -replicationFactor 1
#RUN /opt/solr/bin/solr create -c Sitecore9_fxm_web_index                -d /opt/solr/server/solr/configsets/sitecore_configs/conf -n sitecore_configs -shards 1 -replicationFactor 1
#RUN /opt/solr/bin/solr create -c Sitecore9_xdb                          -d /opt/solr/server/solr/configsets/sitecore_configs/conf -n sitecore_configs -shards 1 -replicationFactor 1
#RUN /opt/solr/bin/solr create -c Sitecore9_xdb_rebuild                  -d /opt/solr/server/solr/configsets/sitecore_configs/conf -n sitecore_configs -shards 1 -replicationFactor 1

# Delete Sitecore 9 indexes if needed
# cd /opt/solr/bin
#./solr delete -c Sitecore9_core_index
#./solr delete -c Sitecore9_master_index
#./solr delete -c Sitecore9_web_index
#./solr delete -c Sitecore9_marketingdefinitions_master
#./solr delete -c Sitecore9_marketingdefinitions_web
#./solr delete -c Sitecore9_marketing_asset_index_master
#./solr delete -c Sitecore9_marketing_asset_index_web
#./solr delete -c Sitecore9_testing_index
#./solr delete -c Sitecore9_suggested_test_index
#./solr delete -c Sitecore9_fxm_master_index
#./solr delete -c Sitecore9_fxm_web_index
#./solr delete -c Sitecore9_xdb
#./solr delete -c Sitecore9_xdb_rebuild

# delete configset
#./zkcli.sh -z zoo-1:2181 -cmd clear /solr

# possible restart service
#./solr restart

# in managed-schema:
# set _datasource required=false
# add id_str as text_general stored=true

#https://docker-host.local:8081/solr/admin/collections?action=CREATE&name=hello&collection.configName=sitecore_configs&maxShardsPerNode=1&numShards=1&replicationFactor=1&router.name=compositeId&routerName=compositeId&wt=json

# delete core separately (if not done through ./solr delete)
#https://docker-host.local:8081/solr/admin/cores?action=UNLOAD&deleteInstanceDir=true&core=Sitecore9_core_index_shard1_replica_n1
#https://docker-host.local:8081/solr/admin/cores?action=UNLOAD&deleteInstanceDir=true&core=Sitecore9_master_index_shard1_replica_n1
#https://docker-host.local:8081/solr/admin/cores?action=UNLOAD&deleteInstanceDir=true&core=Sitecore9_web_index_shard1_replica_n1
#https://docker-host.local:8081/solr/admin/cores?action=UNLOAD&deleteInstanceDir=true&core=Sitecore9_marketingdefinitions_master_shard1_replica_n1
#https://docker-host.local:8081/solr/admin/cores?action=UNLOAD&deleteInstanceDir=true&core=Sitecore9_marketingdefinitions_web_shard1_replica_n1
#https://docker-host.local:8081/solr/admin/cores?action=UNLOAD&deleteInstanceDir=true&core=Sitecore9_marketing_asset_index_master_shard1_replica_n1
#https://docker-host.local:8081/solr/admin/cores?action=UNLOAD&deleteInstanceDir=true&core=Sitecore9_marketing_asset_index_web_shard1_replica_n1
#https://docker-host.local:8081/solr/admin/cores?action=UNLOAD&deleteInstanceDir=true&core=Sitecore9_testing_index_shard1_replica_n1
#https://docker-host.local:8081/solr/admin/cores?action=UNLOAD&deleteInstanceDir=true&core=Sitecore9_suggested_test_index_shard1_replica_n1
#https://docker-host.local:8081/solr/admin/cores?action=UNLOAD&deleteInstanceDir=true&core=Sitecore9_fxm_master_index_shard1_replica_n1
#https://docker-host.local:8081/solr/admin/cores?action=UNLOAD&deleteInstanceDir=true&core=Sitecore9_fxm_web_index_shard1_replica_n1
#https://docker-host.local:8081/solr/admin/cores?action=UNLOAD&deleteInstanceDir=true&core=Sitecore9_xdb_shard1_replica_n1
#https://docker-host.local:8081/solr/admin/cores?action=UNLOAD&deleteInstanceDir=true&core=Sitecore9_xdb_rebuild_shard1_replica_n1
