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