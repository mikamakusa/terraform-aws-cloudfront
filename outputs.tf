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

## Field Level Encryption Profile ##

output "field_level_encryption_profile_id" {
  value = try(
    aws_cloudfront_field_level_encryption_profile.this.*.id
  )
}

output "field_level_encryption_profile_name" {
  value = try(
    aws_cloudfront_field_level_encryption_profile.this.*.name
  )
}

output "field_level_encryption_profile_encryption_entities" {
  value = try(
    aws_cloudfront_field_level_encryption_profile.this.*.encryption_entities
  )
}

## Function ##

output "function_id" {
  value = try(
    aws_cloudfront_function.this.*.id
  )
}

output "function_name" {
  value = try(
    aws_cloudfront_function.this.*.name
  )
}

output "function_arn" {
  value = try(
    aws_cloudfront_function.this.*.arn
  )
}

output "function_status" {
  value = try(
    aws_cloudfront_function.this.*.status
  )
}

## Origin Access Control ##

output "origin_access_control_id" {
  value = try(
    aws_cloudfront_origin_access_control.this.*.id
  )
}

output "origin_access_control_name" {
  value = try(
    aws_cloudfront_origin_access_control.this.*.name
  )
}

output "origin_access_control_etag" {
  value = try(
    aws_cloudfront_origin_access_control.this.*.etag
  )
}

output "origin_access_control_signing_behavior" {
  value = try(
    aws_cloudfront_origin_access_control.this.*.signing_behavior
  )
}

output "origin_access_control_origin_type" {
  value = try(
    aws_cloudfront_origin_access_control.this.*.origin_access_control_origin_type
  )
}

output "origin_access_control_signing_protocol" {
  value = try(
    aws_cloudfront_origin_access_control.this.*.signing_protocol
  )
}

## Origin Request Policy ##

output "origin_request_policy_id" {
  value = try(
    aws_cloudfront_origin_request_policy.this.*.id
  )
}

output "origin_request_policy_name" {
  value = try(
    aws_cloudfront_origin_request_policy.this.*.name
  )
}

output "origin_request_policy_etag" {
  value = try(
    aws_cloudfront_origin_request_policy.this.*.etag
  )
}

output "origin_request_policy_query_strings_config" {
  value = try(
    aws_cloudfront_origin_request_policy.this.*.query_strings_config
  )
}

output "origin_request_policy_headers_config" {
  value = try(
    aws_cloudfront_origin_request_policy.this.*.headers_config
  )
}

output "origin_request_policy_cookies_config" {
  value = try(
    aws_cloudfront_origin_request_policy.this.*.cookies_config
  )
}

## Public Key ##

output "public_key_id" {
  value = try(
    aws_cloudfront_public_key.this.*.id
  )
}

output "public_key_name" {
  value = try(
    aws_cloudfront_public_key.this.*.name
  )
}

output "public_key_etag" {
  value = try(
    aws_cloudfront_public_key.this.*.etag
  )
}