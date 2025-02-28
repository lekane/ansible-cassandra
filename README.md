# ansible-cassandra

Ansible provisioning/maintenance tasks for Cassandra. Can be used to install & manage upgrades for an Apache Cassandra or Datastax (DCE or DSE+Opscenter) based Cassandra cluster & Spark

Usage:

1. Create the servers for Cassandra and other services (e.g Datastax OpsCenter, Spark master)
2. Define an Ansible inventory (see inventory/example.hosts) for your environment
3. Run the playbook to install Cassandra + other services

Inventory configuration:

 Inventory group     | Variable                       | Options                                                  | Default        | Description                                                                                                     
---------------------|--------------------------------|----------------------------------------------------------|----------------|-----------------------------------------------------------------------------------------------------------------
 cassandra_nodes     | dc                             | DC1, DC2, ...                                            | -              | data center of node                                                                                             
 cassandra_nodes     | rack                           | RAC1, RAC2, ...                                          | -              | rack of node                                                                                                    
 cassandra_nodes     | seed                           | true, false                                              | -              | is the node a seed                                                                                              
 cassandra_nodes     | node_ip                        | true, false                                              | -              | IP for internal cluster communications                                                                          
 cassandra_nodes     | spark_enabled                  | true, false                                              | false          | enable Spark on node (DSE only)                                                                                 
 cassandra_nodes     | aws_jars                       | true, false                                              | false          | download jars for aws sdk and hadoop ( required for writing to s3 directly from spark)                          
 cassandra_nodes     | s3_backup_enabled              | true, false                                              | false          | enable S3 backups                                                                                               
 cassandra_nodes     | s3_backup_environment          | aws, riakcs                                              | -              | environment for S3 backups                                                                                      
 cassandra_nodes     | s3_backup_host                 | host                                                     | -              | S3 host (for non-AWS)                                                                                           
 cassandra_nodes     | s3_backup_bucket               | bucket                                                   | -              | S3 bucket where to store backups                                                                                
 cassandra_nodes     | s3_backup_keyspaces            | keyspace,keyspace,...                                    | -              | Cassandra keyspaces to backup (comma separated)                                                                 
 cassandra_nodes     | s3_backup_access_key           | access_key                                               | -              | S3 access key                                                                                                   
 cassandra_nodes     | s3_backup_secret_key           | secret_key                                               | -              | S3 secret key                                                                                                   
 cassandra_nodes     | local_jmx                      | yes, no                                                  | yes            | JMX local only                                                                                                  
 cassandra_nodes     | admin_jmx_remote_password      | password                                                 | -              | JMX password for admin (readwrite)                                                                              
 cassandra_nodes     | monitoring_jmx_remote_password | password                                                 | -              | JMX password for monitoring (readonly)                                                                          
 cassandra_nodes     | unauthorized_jmx               | yes, no                                                  | no             | allow unauthorized access, careful with this one! local_jmx=no and unauthorized_jmx=no will require password for local connections as well
---                 | ---                            | ---                                                      | ---            
 opscenter_nodes     | node_ip                        | true, false                                              | -              | IP for internal cluster communications                                                                          
 ---                 | ---                            | ---                                                      | ---            
 all_cassandra_nodes | data_disk_environment          | ephemeral_raid, directory_symlink, create_data_directory,ephemeral_nvme | ephemeral_raid | data disk options                                                                                               
 all_cassandra_nodes | data_disk_symlink              | symlink name                                             | -              | name of symlink when using "directory_symlink" data_disk_environment                                            
 all_cassandra_nodes | deployment_environment         | aws, euca                                                | -              | environment for installation                                                                                    
 all_cassandra_nodes | install_version                | apache, dce, dse                                         | -              | Cassandra to install (apache=Apache Cassandra, dce=Datastax Community Edition, dse=Datastax Enterprise Edition) 
 all_cassandra_nodes | ignore_shutdown_errors         | true, false                                              | false          | Should we ignore errors with graceful node shutdown                                                             
 all_cassandra_nodes | dse_username                   | DSE username                                             | -              | DSE username (only for DSE install)                                                                             
 all_cassandra_nodes | dse_password                   | DSE password                                             | -              | DSE password (only for DSE install)                                                                             
 all_spark_nodes     | common_ssh_key                 | public ssh key                                           | -              | add a common pre-existing ssh key for easier node management                                                    
 all_spark_nodes     | nfs_mount                      | true, false                                              | false          | is there an NFS mount to add to the spark instances                                                             
 all_spark_nodes     | nfs_mount_target               | nfs mount target address:/dir                            | -              | nfs mount target, ie: 192.168.1.66:/shared_data                                                                 
 all_spark_nodes     | nfs_sharedisc_dir              | mount local directory name                               | -              | local directory to use fo nfs mount, ie: shared_disc                                                            

Requirements:

- Ansible 2.0 or later
- Nodes running Ubuntu 14.04 or later
- Node have the following installed: git

Running:

- Check out main cassandra.yml comments for typical running options (e.g. new install, upgrade, cron/backup only updates etc)

Data disk environment options:
Deployment data options are controlled by the required "data_disk_environment" environment variable, which can be set for all nodes or per-node basis.
The supported environments are:

- ephemeral_raid: Creates a RAID-0 array for local ephemeral drives. Works also for a single ephemeral drive. (default)
- directory_symlink: Creates a symlink from "data_disk_symlink" to /data.
- create_data_directory: Creates /data directory on root device.

Spark setup:
Typical way of setting up the environment would be to define 2 Cassandra data centers: one for real-time transactions (plain Cassandra) and
another for analytics workloads (Cassandra with co-located Spark nodes). You can also use the playbook without installing Spark.

Notes:

- DCE to Apache Cassandra migration: As Datastax dropped support for DCE (3.0.9 is the last supported version), it is recommended you migrate to
  Apache Cassandra based setup (or run DSE). The migration path we took in our clusters was an round-robin DCE->Apache migration (graceful shutdown of node, removal of DCE, running the playbook with default setup on the node (installs &
  configures Apache Cassandra and keeps the old node data)). You'll probably want to set
  ignore_shutdown_errors=true so that the playbook will run when the old binaries have been remove & service isn't running.
