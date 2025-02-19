data "aws_region" "current" {
}

module "cluster_metadata" {
  source = "../../common/metadata"

  name_prefix = local.name_prefix
  base_domain = local.base_domain

  provider_name   = "aws"
  provider_region = data.aws_region.current.name
}

module "cluster" {
  source = "../_modules/eks"

  metadata_name   = module.cluster_metadata.name
  metadata_fqdn   = module.cluster_metadata.fqdn
  metadata_labels = module.cluster_metadata.labels

  availability_zones = local.cluster_availability_zones
  instance_type      = local.cluster_instance_type
  desired_capacity   = local.cluster_desired_capacity
  max_size           = local.cluster_max_size
  min_size           = local.cluster_min_size

  aws_auth_map_roles    = local.cluster_aws_auth_map_roles
  aws_auth_map_users    = local.cluster_aws_auth_map_users
  aws_auth_map_accounts = local.cluster_aws_auth_map_accounts
}
