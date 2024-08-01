resource "aws_cloudfront_cache_policy" "this" {
  count       = length(var.cache_policy)
  name        = lookup(var.cache_policy[count.index], "name")
  comment     = lookup(var.cache_policy[count.index], "comment")
  default_ttl = lookup(var.cache_policy[count.index], "default_ttl")
  max_ttl     = lookup(var.cache_policy[count.index], "max_ttl")
  min_ttl     = lookup(var.cache_policy[count.index], "min_ttl")

  dynamic "parameters_in_cache_key_and_forwarded_to_origin" {
    for_each = lookup(var.cache_policy[count.index], "parameters")
    iterator = parameters
    content {
      enable_accept_encoding_brotli = lookup(parameters.value, "enable_accept_encoding_brotli")
      enable_accept_encoding_gzip   = lookup(parameters.value, "enable_accept_encoding_gzip")

      dynamic "cookies_config" {
        for_each = lookup(parameters.value, "cookies_config")
        content {
          cookie_behavior = lookup(cookies_config.value, "cookie_behavior")

          dynamic "cookies" {
            for_each = try(lookup(cookies_config.value, "cookies") == null ? [] : ["cookies"])
            content {
              items = lookup(cookies.value, "items")
            }
          }
        }
      }
      dynamic "headers_config" {
        for_each = lookup(parameters.value, "headers_config")
        content {
          header_behavior = lookup(headers_config.value, "header_behavior")

          dynamic "headers" {
            for_each = try(lookup(headers_config.value, "headers") == null ? [] : ["headers"])
            content {
              items = lookup(headers.value, "items")
            }
          }
        }
      }
      dynamic "query_strings_config" {
        for_each = lookup(parameters.value, "query_strings_config")
        content {
          query_string_behavior = lookup(query_strings_config.value, "query_string_behavior")

          dynamic "query_strings" {
            for_each = try(lookup(query_strings_config.value, "query_strings") == null ? [] : ["query_strings"])
            content {
              items = lookup(query_strings.value, "items")
            }
          }
        }
      }
    }
  }
}