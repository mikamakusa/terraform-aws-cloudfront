## Cache Policy ##

output "cache_policy_id" {
  value = try(
    aws_cloudfront_cache_policy.this.*.id
  )
}

output "cache_policy_name" {
  value = try(
    aws_cloudfront_cache_policy.this.*.name
  )
}

output "cache_policy_default_ttl" {
  value = try(
    aws_cloudfront_cache_policy.this.*.default_ttl
  )
}

## continuous_deployment_policy ##

output "continuous_deployment_policy_id" {
  value = try(
    aws_cloudfront_continuous_deployment_policy.this.*.id
  )
}

output "continuous_deployment_policy_etag" {
  value = try(
    aws_cloudfront_continuous_deployment_policy.this.*.etag
  )
}

output "continuous_deployment_policy_last_modified_time" {
  value = try(
    aws_cloudfront_continuous_deployment_policy.this.*.last_modified_time
  )
}

output "continuous_deployment_policy_enabled" {
  value = try(
    aws_cloudfront_continuous_deployment_policy.this.*.enabled
  )
}

## Distribution ##

output "distribution_id" {
  value = try(
    aws_cloudfront_distribution.this.*.id
  )
}

output "distribution_arn" {
  value = try(
    aws_cloudfront_distribution.this.*.arn
  )
}

output "distribution_domain_name" {
  value = try(
    aws_cloudfront_distribution.this.*.domain_name
  )
}

output "distribution_status" {
  value = try(
    aws_cloudfront_distribution.this.*.status
  )
}

output "distribution_etag" {
  value = try(
    aws_cloudfront_distribution.this.*.etag
  )
}

## Field Level Encryption Config ##

output "field_level_encryption_config_id" {
  value = try(
    aws_cloudfront_field_level_encryption_config.this.*.id
  )
}

output "field_level_encryption_config_comment" {
  value = try(
    aws_cloudfront_field_level_encryption_config.this.*.comment
  )
}

output "field_level_encryption_config_etag" {
  value = try(
    aws_cloudfront_field_level_encryption_config.this.*.etag
  )
}