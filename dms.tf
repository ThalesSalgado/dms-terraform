resource "aws_dms_endpoint" "target-rds" {
  endpoint_id                 = "target-rds"
  endpoint_type               = "target"
  engine_name                 = "${var.target_engine}"
  server_name                 = "${var.target_rds_server}"
  port                        = "${var.target_rds_db_port}"
  database_name               = "${var.target_rds_db_name}"
  username                    = "${var.target_rds_username}"
  password                    = "${var.target_rds_password}"
#   certificate_arn             = "arn:aws:acm:us-east-1:123456789012:certificate/12345678-1234-1234-1234-123456789012"
#   extra_connection_attributes = ""
#   kms_key_arn                 = "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012"
#   ssl_mode                    = "none"

  tags = {
    Name = "dms-target-rds-endpoint"
  }
}

resource "aws_dms_endpoint" "source-s3" {
  endpoint_id                 = "source-s3"
  endpoint_type               = "source"
  engine_name                 = "${var.source_engine}"
  s3_settings                 = {
    bucket_name               = "${var.source_bucket_name}"
    csv_row_delimiter         = "${var.source_csv_row_delimiter}"
    csv_delimiter             = "${var.source_csv_delimiter}"
    service_access_role_arn   = "${var.source_access_role_arn}"
    external_table_definition = "${file(var.source_external_table_definition_path)}"
    # compression_type        = "${var.source_compression_type}"
  }

  tags = {
    Name = "dms-source-s3-endpoint"
  }
}

resource "aws_dms_endpoint" "source-s3-userinfotest" {
  endpoint_id                 = "source-s3-userinfotest"
  endpoint_type               = "source"
  engine_name                 = "${var.source_engine}"
  s3_settings                 = {
    bucket_name               = "${var.source_bucket_name}"
    csv_row_delimiter         = "${var.source_csv_row_delimiter}"
    csv_delimiter             = "${var.source_csv_delimiter}"
    service_access_role_arn   = "${var.source_access_role_arn}"
    external_table_definition = "${file(var.source_external_table_definition_path_userinfotest)}"
    # compression_type        = "${var.source_compression_type}"
  }

  tags = {
    Name = "dms-source-s3-endpoint-userinfotest"
  }
}

resource "aws_dms_endpoint" "source-s3-PK" {
  endpoint_id                 = "source-s3-PK"
  endpoint_type               = "source"
  engine_name                 = "${var.source_engine}"
  s3_settings                 = {
    bucket_name               = "${var.source_bucket_name}"
    csv_row_delimiter         = "${var.source_csv_row_delimiter}"
    csv_delimiter             = "${var.source_csv_delimiter}"
    service_access_role_arn   = "${var.source_access_role_arn}"
    external_table_definition = "${file(var.source_external_table_definition_PK_path)}"
    # compression_type        = "${var.source_compression_type}"
  }

  tags = {
    Name = "dms-source-s3-endpoint"
  }
}





data "aws_iam_policy_document" "dms_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["dms.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_role" "dms-access-for-endpoint" {
  assume_role_policy = "${data.aws_iam_policy_document.dms_assume_role.json}"
  name               = "dms-access-for-endpoint"
}

resource "aws_iam_role_policy_attachment" "dms-access-for-endpoint-AmazonDMSRedshiftS3Role" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonDMSRedshiftS3Role"
  role       = "${aws_iam_role.dms-access-for-endpoint.name}"
}

resource "aws_iam_role" "dms-cloudwatch-logs-role" {
  assume_role_policy = "${data.aws_iam_policy_document.dms_assume_role.json}"
  name               = "dms-cloudwatch-logs-role"
}

resource "aws_iam_role_policy_attachment" "dms-cloudwatch-logs-role-AmazonDMSCloudWatchLogsRole" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonDMSCloudWatchLogsRole"
  role       = "${aws_iam_role.dms-cloudwatch-logs-role.name}"
}

resource "aws_iam_role" "dms-vpc-role" {
  assume_role_policy = "${data.aws_iam_policy_document.dms_assume_role.json}"
  name               = "dms-vpc-role"
}

resource "aws_iam_role_policy_attachment" "dms-vpc-role-AmazonDMSVPCManagementRole" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonDMSVPCManagementRole"
  role       = "${aws_iam_role.dms-vpc-role.name}"
}

resource "aws_dms_replication_subnet_group" "dms-subnet-group" {
  replication_subnet_group_description = "Test replication subnet group"
  replication_subnet_group_id          = "test-dms-replication-subnet-group-tf"

  # subnet_ids = [
  #   "${aws_subnet.public_subnet.*.id}"
  # ]

  subnet_ids = ["${flatten(chunklist(aws_subnet.public_subnet.*.id, 1))}"]

  tags = {
    Name = "dms-subnet-group"
  }
}

resource "aws_dms_replication_instance" "dms-micro" {
  allocated_storage            = 20
  apply_immediately            = true
  auto_minor_version_upgrade   = true
  availability_zone            = "us-east-1a"
  engine_version               = "3.1.3"
  multi_az                     = false
  publicly_accessible          = true
  replication_instance_class   = "dms.t2.micro"
  replication_instance_id      = "dms-micro"
  preferred_maintenance_window = "sun:10:30-sun:14:30"
  replication_subnet_group_id  = "${aws_dms_replication_subnet_group.dms-subnet-group.id}"
  # kms_key_arn                  = "arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012"

  tags = {
    Name = "dms-micro"
  }

  # vpc_security_group_ids = [
  #   "${aws_security_group.dms.id}"
  # ]
}





resource "aws_dms_replication_task" "employee-migration" {
  migration_type            = "full-load"
  replication_instance_arn  = "${aws_dms_replication_instance.dms-micro.replication_instance_arn}"
  replication_task_id       = "employee-migration"
  source_endpoint_arn       = "${aws_dms_endpoint.source-s3.endpoint_arn}"
  target_endpoint_arn       = "${aws_dms_endpoint.target-rds.endpoint_arn}"
  table_mappings            = "${file(var.dms-task-table-mapping-path)}"
  replication_task_settings = "${file(var.dms-task-settings-employee-path)}"
  # cdc_start_time            = 1484346880

  tags = {
    Name = "employee-migration"
  }
}