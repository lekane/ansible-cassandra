# ansible-cassandra
Ansible provisioning/maintenance tasks for Cassandra

Usage:

1. Create the servers for Cassandra and Datastax OpsCenter
2. Define an Ansible inventory (see inventory/example.hosts) for your environment
3. Run the playbook to install Cassandra + Datastax OpsCenter

Inventory configuration:

Inventory group | Variable | Options | Description
--- | --- | --- | ---
cassandra_nodes | dc | DC1, DC2, ... | data center of node
cassandra_nodes | deployment_environment | aws, euca | environment for installation
cassandra_nodes | rack | RAC1, RAC2, ... | rack of node
cassandra_nodes | repair_weekday | MON,TUE,WED,THU,FRI,SAT,SUN | day(s) to run repair on node
cassandra_nodes | seed | true, false | is the node a seed
cassandra_nodes | node_ip | true, false | IP for internal cluster communications
--- | --- | --- | ---
opscenter_nodes | deployment_environment | aws, euca | environment for installation
opscenter_nodes | node_ip | true, false | IP for internal cluster communications

Requirements:
- Ansible 1.8 or later
- Ansible general configuration: "jinja2_extensions = jinja2.ext.do"
- Nodes running Ubuntu 14.04 or later
