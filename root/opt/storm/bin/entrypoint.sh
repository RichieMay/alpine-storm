#!/bin/sh

gen_conf() 
{
cat << EOF > ${SERVICE_CONF}
storm.zookeeper.servers:
     - "131.10.10.202"
     - "131.10.10.203"
     - "131.10.10.204"
nimbus.seeds: ["cluster202"]
storm.local.dir: "/opt/cluster/storm/data"
supervisor.slots.ports:
       - 6700
       - 6701
       - 6702
       - 6703
storm.zookeeper.port: 2181
ui.port: 8080
EOF
}

gen_conf

while true
do
	sleep 1
done

echo $*

printf "/stacks/zookeeper/services/zk/containers"

# ZK={{range \$i, \$e := ls (printf "/stacks/%s/services/%s/containers" \$zk_stack \$zk_service)}}{{if \$i}},{{end}}{{getv (printf "/stacks/%s/services/%s/containers/%s/primary_ip" \$zk_stack \$zk_service \$e)}}:2181{{end}}

