# ansible-cassandra
Ansible provisioning/maintenance tasks for Cassandra

Usage:

1. Create the servers for Cassandra and Datastax OpsCenter
2. Define an Ansible inventory (see inventory/example.hosts) for your environment
3. Run the playbook to install Cassandra + Datastax OpsCenter

Inventory configuration:

Inventory group | Variable | Options | Default | Description
--- | --- | --- | --- | ---
cassandra_nodes | dc | DC1, DC2, ... | - | data center of node
cassandra_nodes | deployment_environment | aws, euca | - | environment for installation
cassandra_nodes | rack | RAC1, RAC2, ... | - | rack of node
cassandra_nodes | repair_weekday | MON,TUE,WED,THU,FRI,SAT,SUN | - | day(s) to run repair on node
cassandra_nodes | seed | true, false | - | is the node a seed
cassandra_nodes | node_ip | true, false | - | IP for internal cluster communications
cassandra_nodes | s3_backup_enabled | true, false | false | enable S3 backups
cassandra_nodes | s3_backup_environment | aws, riakcs | - | environment for S3 backups
cassandra_nodes | s3_backup_host| <host> | - | S3 host (for non-AWS)
cassandra_nodes | s3_backup_bucket | <bucket> | - | S3 bucket where to store backups
cassandra_nodes | s3_backup_keyspace | <keyspace> | - | Cassandra keyspace to backup
cassandra_nodes | s3_backup_access_key | <access_key> | - | S3 access key
cassandra_nodes | s3_backup_secret_key | <secret_key> | - | S3 secret key
--- | --- | --- | ---
opscenter_nodes | deployment_environment | aws, euca | - | environment for installation
opscenter_nodes | node_ip | true, false | - | IP for internal cluster communications

Requirements:
- Ansible 1.8 or later
- Ansible general configuration: "jinja2_extensions = jinja2.ext.do"
- Nodes running Ubuntu 14.04 or later
