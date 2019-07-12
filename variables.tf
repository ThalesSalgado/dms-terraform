variable "availability_zones" { 
  default = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c"
  ]
}

variable "my_public_ip" {}

variable "target_engine" {
  description = "Engine type, example values mysql, postgres"
  default     = "postgres"
}

variable "target_rds_server" {
  description = "Rds server"
  default = "tjds-dms-rds.cv9j8wfjwsad.us-east-1.rds.amazonaws.com"
}

variable "target_rds_db_port" {
  description = "Rds port"
  default = 5432
}

variable "target_rds_db_name" {
  description = "Name of the target database"
  default = "tjds"
}

variable "target_rds_username" {
  description = "Username for Rds"
  default = "tjds"
}

variable "target_rds_password" {
  description = "Password for Rds"
  default = "tjds4242"
}

variable "source_engine" {
  description = "Engine type, example values s3, mysql, postgres"
  default     = "s3"
}

variable "source_access_role_arn" {
  description = "Service access role arn to access S3"
  default = "arn:aws:iam::198930388053:role/dms-vpc-role"
}

variable "source_csv_row_delimiter" {
  default = "\\n"
}

variable "source_csv_delimiter" {
  default = ","
}

variable "source_bucket_name" {
  default = "tjds-dms-test"
}

variable "source_compression_type" {
  default = "GZIP"
}

variable "source_external_table_definition_path" {
  default = "json/endpoint-table-definition-employee.json"
}

variable "source_external_table_definition_PK_path" {
  default = "json/endpoint-table-definition-employee-PK.json"
}

variable "source_external_table_definition_path_userinfotest" {
  default = "json/endpoint-table-definition-userInfoTest.json"
}

variable "dms-instance-vpc-policy-path" {
  default = "json/dmsVpcRolePolicy.json"
}

variable "dms-instance-cloudwatch-policy-path" {
  default = "json/dmsCloudwatchLogsRolePolicy.json"
}

variable "dms-instance-endpoint-policy-path" {
  default = "json/dmsEndpointAccesRolePolicy.json"
}

variable "dms-task-table-mapping-path" {
  default = "json/tableMappingsDmsTask.json"
}

variable "dms-task-settings-employee-path" {
  default = "json/dms-task-settings-employee.json"
}










# variable "target_engine_version" {
#   description = "Engine version"
#   default     = "9.3.14"
# }

# variable "target_instance_class" {
#   default     = "db.t2.micro"
#   description = "Instance class"
# }

# variable "target_maintenance_window" {
#   default     = "Mon:00:00-Mon:03:00"
#   description = "RDS maintenance window"
# }

# variable "target_password" {
#   description = "Password of the target database"
# }

# variable "target_rds_is_multi_az" {
#   description = "Create backup database in separate availability zone"
#   default     = "false"
# }

# variable "target_storage" {
#   default     = "10"
#   description = "Storage size in GB"
# }

# variable "target_storage_encrypted" {
#   description = "Encrypt storage or leave unencrypted"
#   default     = false
# }

# variable "target_username" {
#   description = "Username to access the target database"
# }

# #--------------------------------------------------------------
# # DMS source config
# #--------------------------------------------------------------
# variable "source_app_password" {
#   description = "Password for the endpoint to access the source database"
# }

# variable "source_app_username" {
#   description = "Username for the endpoint to access the source database"
# }

# variable "source_backup_retention_period" {
#   # Days
#   default     = "1"
#   description = "Retention of RDS backups"
# }

# variable "source_backup_window" {
#   # 12:00AM-03:00AM AEST
#   default     = "14:00-17:00"
#   description = "RDS backup window"
# }

# variable "source_db_name" {
#   description = "Password of the target database"
#   default     = "ORACLE"
# }

# variable "source_db_port" {
#   description = "The port the Application Server will access the database on"
#   default     = 1521
# }

# variable "source_engine" {
#   default     = "oracle-se2"
#   description = "Engine type, example values mysql, postgres"
# }

# variable "source_engine_name" {
#   default     = "oracle"
#   description = "Engine name for DMS"
# }

# variable "source_engine_version" {
#   description = "Engine version"
#   default     = "12.1.0.2.v8"
# }

# variable "source_instance_class" {
#   default     = "db.t2.micro"
#   description = "Instance class"
# }

# variable "source_maintenance_window" {
#   default     = "Mon:00:00-Mon:03:00"
#   description = "RDS maintenance window"
# }

# variable "source_password" {
#   description = "Password of the source database"
# }

# variable "source_rds_is_multi_az" {
#   description = "Create backup database in separate availability zone"
#   default     = "false"
# }

# variable "source_snapshot" {
#   description = "Snapshot ID"
# }

# variable "source_storage" {
#   default     = "10"
#   description = "Storage size in GB"
# }

# variable "source_storage_encrypted" {
#   description = "Encrypt storage or leave unencrypted"
#   default     = false
# }

# variable "source_username" {
#   description = "Username to access the source database"
# }

# #--------------------------------------------------------------
# # DMS Replication Instance
# #--------------------------------------------------------------
# variable "replication_instance_maintenance_window" {
#   description = "Maintenance window for the replication instance"
#   default     = "sun:10:30-sun:14:30"
# }

# variable "replication_instance_storage" {
#   description = "Size of the replication instance in GB"
#   default     = "10"
# }

# variable "replication_instance_version" {
#   description = "Engine version of the replication instance"
#   default     = "1.9.0"
# }

# variable "replication_instance_class" {
#   description = "Instance class of replication instance"
#   default     = "dms.t2.micro"
# }

# #--------------------------------------------------------------
# # Network
# #--------------------------------------------------------------
# variable "database_subnet_cidr" {
#   default     = ["10.0.0.0/26", "10.0.0.64/26", "10.0.0.128/26"]
#   description = "List of subnets to be used for databases"
# }

# variable "vpc_cidr" {
#   description = "CIDR for the whole VPC"
#   default     = "10.0.0.0/24"
# }