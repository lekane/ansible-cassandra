# ansible-cassandra
Ansible provisioning/maintenance tasks for Cassandra. Can be used to install & manage upgrades for an Apache Cassandra or Datastax (DCE or DSE+Opscenter) based Cassandra cluster & Spark

Usage:

1. Create the servers for Cassandra and other services (e.g Datastax OpsCenter, Spark master)
2. Define an Ansible inventory (see inventory/example.hosts) for your environment
3. Run the playbook to install Cassandra + other services

Inventory configuration:

Inventory group | Variable | Options | Default | Description
--- | --- | --- | --- | ---
cassandra_nodes | dc | DC1, DC2, ... | - | data center of node
cassandra_nodes | rack | RAC1, RAC2, ... | - | rack of node
cassandra_nodes | repair_weekday | MON,TUE,WED,THU,FRI,SAT,SUN | - | day(s) to run repair on node
cassandra_nodes | repair_start_hour | 00-23 | 03 | hour to start cron based repair
cassandra_nodes | repair_start_minute | 00-59 | 0 | minute to start cron based repair
cassandra_nodes | seed | true, false | - | is the node a seed
cassandra_nodes | node_ip | true, false | - | IP for internal cluster communications
cassandra_nodes | spark_enabled | true, false | false | enable Spark on node (DSE only)
cassandra_nodes | s3_backup_enabled | true, false | false | enable S3 backups
cassandra_nodes | s3_backup_environment | aws, riakcs | - | environment for S3 backups
cassandra_nodes | s3_backup_host| host | - | S3 host (for non-AWS)
cassandra_nodes | s3_backup_bucket | bucket | - | S3 bucket where to store backups
cassandra_nodes | s3_backup_keyspaces | keyspace,keyspace,... | - | Cassandra keyspaces to backup (comma separated)
cassandra_nodes | s3_backup_access_key | access_key | - | S3 access key
cassandra_nodes | s3_backup_secret_key | secret_key | - | S3 secret key
cassandra_nodes | local_jmx | yes, no | yes | JMX local only
cassandra_nodes | admin_jmx_remote_password| password | - | JMX password for admin (readwrite)
cassandra_nodes | monitoring_jmx_remote_password | password| - | JMX password for monitoring (readonly)
--- | --- | --- | ---
opscenter_nodes | node_ip | true, false | - | IP for internal cluster communications
--- | --- | --- | ---
all_cassandra_nodes | deployment_environment | aws, euca | - | environment for installation
all_cassandra_nodes | install_version | apache, dce, dse | - | Cassandra to install (apache=Apache Cassandra, dce=Datastax Community Edition, dse=Datastax Enterprise Edition)
all_cassandra_nodes | ignore_shutdown_errors | true, false | false | Should we ignore errors with graceful node shutdown
all_cassandra_nodes | dse_username | DSE username | - | DSE username (only for DSE install)
all_cassandra_nodes | dse_password | DSE password | - | DSE password (only for DSE install)

Requirements:
- Ansible 2.0 or later
- Nodes running Ubuntu 14.04 or later
- Node have the following installed: git

Running:
- Check out main cassandra.yml comments for typical running options (e.g. new install, upgrade, cron/backup only updates etc)

Spark setup:
Typical way of setting up the environment would be to define 2 Cassandra data centers: one for real-time transactions (plain Cassandra) and
another for analytics workloads (Cassandra with co-located Spark nodes). You can also use the playbook without installing Spark.

Notes:
- DCE to Apache Cassandra migration: As Datastax dropped support for DCE (3.0.9 is the last supported version), it is recommended you migrate to 
Apache Cassandra based setup (or run DSE). The migration path we took in our clusters was an round-robin DCE->Apache migration (graceful shutdown of node, removal of DCE, running the playbook with default setup on the node (installs & configures Apache Cassandra and keeps the old node data)). You'll probably want to set
ignore_shutdown_errors=true so that the playbook will run when the old binaries have been remove & service isn't running.
