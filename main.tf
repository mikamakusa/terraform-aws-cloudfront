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

resource "aws_cloudfront_continuous_deployment_policy" "this" {
  count   = length(var.continuous_deployment_policy)
  enabled = lookup(var.continuous_deployment_policy[count.index], "enabled")

  dynamic "staging_distribution_dns_names" {
    for_each = lookup(var.continuous_deployment_policy[count.index], "staging_distribution_dns_names")
    content {
      quantity = lookup(staging_distribution_dns_names.value, "quantity")
      items    = lookup(staging_distribution_dns_names.value, "items")
    }
  }

  dynamic "traffic_config" {
    for_each = lookup(var.continuous_deployment_policy[count.index], "traffic_config")
    content {
      type = lookup(traffic_config.value, "type")

      dynamic "single_header_config" {
        for_each = try(lookup(traffic_config.value, "single_header_config") == null ? [] : ["single_header_config"])
        content {
          header = lookup(single_header_config.value, "header")
          value  = lookup(single_header_config.value, "value")
        }
      }

      dynamic "single_weight_config" {
        for_each = try(lookup(traffic_config.value, "single_weight_config") == null ? [] : ["single_weight_config"])
        content {
          weight = lookup(single_weight_config.value, "weight")

          dynamic "session_stickiness_config" {
            for_each = try(lookup(single_weight_config.value, "session_stickiness_config") == null ? [] : ["session_stickiness_config"])
            content {
              idle_ttl    = lookup(session_stickiness_config.value, "idle_ttl")
              maximum_ttl = lookup(session_stickiness_config.value, "maximum_ttl")
            }
          }
        }
      }
    }
  }
}

resource "aws_cloudfront_distribution" "this" {
  count                           = length(var.distribution)
  enabled                         = lookup(var.distribution[count.index], "enabled")
  aliases                         = lookup(var.distribution[count.index], "aliases")
  comment                         = lookup(var.distribution[count.index], "comment")
  continuous_deployment_policy_id = lookup(var.distribution[count.index], "continuous_deployment_policy_id")
  default_root_object             = lookup(var.distribution[count.index], "default_root_object")
  http_version                    = lookup(var.distribution[count.index], "http_version")
  id                              = lookup(var.distribution[count.index], "id")
  is_ipv6_enabled                 = lookup(var.distribution[count.index], "is_ipv6_enabled")
  price_class                     = lookup(var.distribution[count.index], "price_class")
  retain_on_delete                = lookup(var.distribution[count.index], "retain_on_delete")
  staging                         = lookup(var.distribution[count.index], "staging")
  tags = merge(
    data.aws_default_tags.this.tags,
    var.tags,
    lookup(var.distribution[count.index], "tags")
  )
  wait_for_deployment = lookup(var.distribution[count.index], "wait_for_deployment")
  web_acl_id = lookup(var.distribution[count.index], "web_acl_id") != null ? try(
    element(var.web_acl_id, lookup(var.distribution[count.index], "web_acl_id"))
  ) : var.web_acl_id

  dynamic "custom_error_response" {
    for_each = lookup(var.distribution[count.index], "custom_error_response") == null ? [] : ["custom_error_response"]
    content {
      error_code            = lookup(custom_error_response.value, "error_code")
      error_caching_min_ttl = lookup(custom_error_response.value, "error_caching_min_ttl")
      response_code         = lookup(custom_error_response.value, "response_code")
      response_page_path    = lookup(custom_error_response.value, "response_page_path")
    }
  }

  dynamic "default_cache_behavior" {
    for_each = lookup(var.distribution[count.index], "default_cache_behavior")
    content {
      allowed_methods = lookup(default_cache_behavior.value, "allowed_methods")
      cached_methods  = lookup(default_cache_behavior.value, "cached_methods")
      target_origin_id = lookup(default_cache_behavior.value, "target_origin_id") != null ? try(
        element(var.target_origin_id, lookup(default_cache_behavior.value, "target_origin_id"))
      ) : var.target_origin_id
      viewer_protocol_policy = lookup(default_cache_behavior.value, "viewer_protocol_policy")
      cache_policy_id = lookup(default_cache_behavior.value, "cache_policy_id") != null ? try(
        element(var.cache_policy_id, lookup(default_cache_behavior.value, "cache_policy_id"))
      ) : var.cache_policy_id
      compress                  = lookup(default_cache_behavior.value, "compress")
      default_ttl               = lookup(default_cache_behavior.value, "default_ttl")
      field_level_encryption_id = lookup(default_cache_behavior.value, "field_level_encryption_id")
      max_ttl                   = lookup(default_cache_behavior.value, "max_ttl")
      min_ttl                   = lookup(default_cache_behavior.value, "min_ttl")
      origin_request_policy_id  = lookup(default_cache_behavior.value, "origin_request_policy_id")
      realtime_log_config_arn   = lookup(default_cache_behavior.value, "realtime_log_config_arn")
      smooth_streaming          = lookup(default_cache_behavior.value, "smooth_streaming")
      trusted_signers           = lookup(default_cache_behavior.value, "trusted_signers")

      dynamic "forwarded_values" {
        for_each = lookup(default_cache_behavior.value, "forwarded_values") == null ? [] : ["forwarded_values"]
        content {
          query_string            = lookup(forwarded_values.value, "query_string")
          headers                 = lookup(forwarded_values.value, "headers")
          query_string_cache_keys = lookup(forwarded_values.value, "query_string_cache_keys")

          dynamic "cookies" {
            for_each = lookup(forwarded_values.value, "cookies") == null ? [] : ["cookies"]
            content {
              forward           = lookup(cookies.value, "forward")
              whitelisted_names = lookup(cookies.value, "whitelisted_names")
            }
          }
        }
      }

      dynamic "function_association" {
        for_each = lookup(default_cache_behavior.value, "function_association") == null ? [] : ["function_association"]
        content {
          event_type = lookup(function_association.value, "event_type")
          function_arn = lookup(function_association.value, "function_arn") != null ? try(
            element(var.function_arn, lookup(function_association.value, "function_arn"))
          ) : var.function_arn
        }
      }

      dynamic "lambda_function_association" {
        for_each = lookup(default_cache_behavior.value, "lambda_function_association") == null ? [] : ["lambda_function_association"]
        content {
          lambda_arn = lookup(lambda_function_association.value, "lambda_arn") != null ? try(
            element(var.lambda_arn, lookup(lambda_function_association.value, "lambda_arn"))
          ) : var.lambda_arn
          event_type = lookup(lambda_function_association.value, "event_type")
        }
      }
    }
  }

  dynamic "logging_config" {
    for_each = lookup(var.distribution[count.index], "logging_config") == null ? [] : ["logging_config"]
    content {
      bucket          = lookup(logging_config.value, "bucket")
      include_cookies = lookup(logging_config.value, "include_cookies")
      prefix          = lookup(logging_config.value, "prefix")
    }
  }

  dynamic "ordered_cache_behavior" {
    for_each = lookup(var.distribution[count.index], "ordered_cache_behavior") == null ? [] : ["ordered_cache_behavior"]
    content {
      allowed_methods = lookup(ordered_cache_behavior.value, "allowed_methods")
      cached_methods  = lookup(ordered_cache_behavior.value, "cached_methods")
      path_pattern    = lookup(ordered_cache_behavior.value, "path_pattern")
      target_origin_id = lookup(ordered_cache_behavior.value, "target_origin_id") != null ? try(
        element(var.target_origin_id, lookup(ordered_cache_behavior.value, "target_origin_id"))
      ) : var.target_origin_id
      viewer_protocol_policy = lookup(ordered_cache_behavior.value, "viewer_protocol_policy")
    }
  }

  dynamic "origin" {
    for_each = lookup(var.distribution[count.index], "origin") == null ? [] : ["origin"]
    content {
      domain_name = lookup(origin.value, "domain_name") != null ? try(
        element(var.domain_name, lookup(origin.value, "domain_name"))
      ) : var.domain_name
      origin_id   = lookup(origin.value, "origin_id")
      origin_path = lookup(origin.value, "origin_path")

      dynamic "custom_header" {
        for_each = lookup(origin.value, "custom_header") == null ? [] : ["custom_header"]
        content {
          name  = lookup(custom_header.value, "name")
          value = lookup(custom_header.value, "value")
        }
      }

      dynamic "custom_origin_config" {
        for_each = lookup(origin.value, "custom_origin_config") == null ? [] : ["custom_origin_config"]
        content {
          http_port                = lookup(custom_origin_config.value, "http_port")
          https_port               = lookup(custom_origin_config.value, "https_port")
          origin_protocol_policy   = lookup(custom_origin_config.value, "origin_protocol_policy")
          origin_ssl_protocols     = lookup(custom_origin_config.value, "origin_ssl_protocols")
          origin_keepalive_timeout = lookup(custom_origin_config.value, "origin_keepalive_timeout")
          origin_read_timeout      = lookup(custom_origin_config.value, "origin_read_timeout")
        }
      }

      dynamic "s3_origin_config" {
        for_each = lookup(origin.value, "s3_origin_config") == null ? [] : ["s3_origin_config"]
        content {
          origin_access_identity = try(
            element(aws_cloudfront_origin_access_identity.this.*.cloudfront_access_identity_path, lookup(s3_origin_config.value, "origin_access_identity_id"))
          )
        }
      }
    }
  }

  dynamic "origin_group" {
    for_each = lookup(var.distribution[count.index], "origin_group") == null ? [] : ["origin_group"]
    content {
      origin_id = lookup(origin_group.value, "origin_id")

      dynamic "failover_criteria" {
        for_each = lookup(origin_group.value, "failover_criteria") == null ? [] : ["failover_criteria"]
        content {
          status_codes = lookup(failover_criteria.value, "status_codes")
        }
      }

      dynamic "member" {
        for_each = lookup(origin_group.value, "member") == null ? [] : ["member"]
        content {
          origin_id = lookup(member.value, "origin_id")
        }
      }
    }
  }

  dynamic "restrictions" {
    for_each = lookup(var.distribution[count.index], "restrictions") == null ? [] : ["restrictions"]
    content {
      dynamic "geo_restriction" {
        for_each = lookup(restrictions.value, "geo_restriction") == null ? [] : ["geo_restriction"]
        content {
          restriction_type = lookup(geo_restriction.value, "restriction_type")
          locations        = lookup(geo_restriction.value, "locations")
        }
      }
    }
  }

  dynamic "viewer_certificate" {
    for_each = lookup(var.distribution[count.index], "viewer_certificate") == null ? [] : ["viewer_certificate"]
    content {
      acm_certificate_arn = lookup(viewer_certificate.value, "acm_certificate_arn") != null ? try(
        element(var.acm_certificate_arn, lookup(viewer_certificate.value, "acm_certificate_arn"))
      ) : var.acm_certificate_arn
      cloudfront_default_certificate = lookup(viewer_certificate.value, "cloudfront_default_certificate")
      iam_certificate_id = lookup(viewer_certificate.value, "iam_certificate_id") != null ? try(
        element(var.iam_certificate_id, lookup(viewer_certificate.value, "iam_certificate_id"))
      ) : var.iam_certificate_id
      minimum_protocol_version = lookup(viewer_certificate.value, "minimum_protocol_version")
      ssl_support_method       = lookup(viewer_certificate.value, "ssl_support_method")
    }
  }
}

resource "aws_cloudfront_field_level_encryption_config" "this" {
  count   = length(var.field_level_encryption_config)
  comment = lookup(var.field_level_encryption_config[count.index], "comment")

  dynamic "content_type_profile_config" {
    for_each = lookup(var.field_level_encryption_config[count.index], "content_type_profile_config")
    iterator = content_type
    content {
      forward_when_content_type_is_unknown = lookup(content_type.value, "forward_when_content_type_is_unknown")

      dynamic "content_type_profiles" {
        for_each = lookup(content_type.value, "content_type_profiles")
        content {
          dynamic "items" {
            for_each = lookup(content_type_profiles.value, "items") == null ? [] : ["content_type_profiles"]
            content {
              content_type = lookup(items.value, content_type)
              format       = lookup(items.value, format)
              profile_id   = lookup(items.value, profile_id)
            }
          }
        }
      }
    }
  }

  dynamic "query_arg_profile_config" {
    for_each = lookup(var.field_level_encryption_config[count.index], "query_arg_profile_config")
    iterator = query_arg
    content {
      forward_when_query_arg_profile_is_unknown = lookup(query_arg.value, "forward_when_query_arg_profile_is_unknown")

      dynamic "query_arg_profiles" {
        for_each = lookup(query_arg.value, "query_arg_profiles")
        content {
          dynamic "items" {
            for_each = lookup(query_arg_profiles.value, "items") == null ? [] : ["query_arg_profiles"]
            content {
              query_arg  = lookup(items.value, query_arg)
              profile_id = lookup(items.value, profile_id)
            }
          }
        }
      }
    }
  }
}

resource "aws_cloudfront_field_level_encryption_profile" "this" {
  count   = length(var.field_level_encryption_profile)
  name    = lookup(var.field_level_encryption_profile[count.index], "name")
  comment = lookup(var.field_level_encryption_profile[count.index], "comment")

  dynamic "encryption_entities" {
    for_each = lookup(var.field_level_encryption_profile[count.index], "encryption_entities")
    content {
      dynamic "items" {
        for_each = lookup(encryption_entities.value, "items")
        content {
          public_key_id = lookup(items.value, "public_key_id")
          provider_id   = lookup(items.value, "provider_id")

          dynamic "field_patterns" {
            for_each = lookup(items.value, "field_patterns")
            content {
              items = lookup(field_patterns.value, "items")
            }
          }
        }
      }
    }
  }
}

resource "aws_cloudfront_function" "this" {
  count   = length(var.function)
  code    = file(join("/", [path.cwd, "code", lookup(var.function[count.index], "code")]))
  name    = lookup(var.function[count.index], "name")
  runtime = lookup(var.function[count.index], "runtime")
  comment = lookup(var.function[count.index], "comment")
  publish = lookup(var.function[count.index], "publish")
  key_value_store_associations = try(
    element(aws_cloudfront_key_value_store.this.*.arn, lookup(var.function[count.index], "key_value_store_arn"))
  )
}

resource "aws_cloudfront_key_group" "this" {
  count   = length(var.key_group)
  items   = lookup(var.key_group[count.index], "items")
  name    = lookup(var.key_group[count.index], "name")
  comment = lookup(var.key_group[count.index], "comment")
}

resource "aws_cloudfront_key_value_store" "this" {
  count   = length(var.key_value_store)
  name    = lookup(var.key_value_store[count.index], "name")
  comment = lookup(var.key_value_store[count.index], "comment")
}

resource "aws_cloudfront_monitoring_subscription" "this" {
  count = length(var.distribution) == 0 ? 0 : length(var.monitoring_subscription)
  distribution_id = try(
    element(aws_cloudfront_distribution.this.*.id, lookup(var.monitoring_subscription[count.index], "distribution_id"))
  )

  monitoring_subscription {
    realtime_metrics_subscription_config {
      realtime_metrics_subscription_status = lookup(var.monitoring_subscription[count.index], "status")
    }
  }
}

resource "aws_cloudfront_origin_access_control" "this" {
  count                             = length(var.origin_access_control)
  name                              = lookup(var.origin_access_control[count.index], "name")
  origin_access_control_origin_type = lookup(var.origin_access_control[count.index], "origin_access_control_origin_type")
  signing_behavior                  = lookup(var.origin_access_control[count.index], "signing_behavior")
  signing_protocol                  = lookup(var.origin_access_control[count.index], "signing_protocol", "sigv4")
  description                       = lookup(var.origin_access_control[count.index], "description")
}

resource "aws_cloudfront_origin_access_identity" "this" {
  count   = length(var.origin_access_identity)
  comment = lookup(var.origin_access_identity[count.index], "comment")
}

