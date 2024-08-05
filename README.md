## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.60.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.60.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_cache_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_cache_policy) | resource |
| [aws_cloudfront_continuous_deployment_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_continuous_deployment_policy) | resource |
| [aws_cloudfront_distribution.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_field_level_encryption_config.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_field_level_encryption_config) | resource |
| [aws_default_tags.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/default_tags) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_certificate_arn"></a> [acm\_certificate\_arn](#input\_acm\_certificate\_arn) | n/a | `string` | `null` | no |
| <a name="input_cache_policy"></a> [cache\_policy](#input\_cache\_policy) | n/a | <pre>list(object({<br>    id          = number<br>    name        = string<br>    comment     = optional(string)<br>    default_ttl = optional(number)<br>    max_ttl     = optional(number)<br>    min_ttl     = optional(number)<br>    parameters = list(object({<br>      enable_accept_encoding_brotli = optional(bool)<br>      enable_accept_encoding_gzip   = optional(bool)<br>      cookies_config = list(object({<br>        cookie_behavior = string<br>        cookies = optional(list(object({<br>          items = set(string)<br>        })), [])<br>      }))<br>      headers_config = list(object({<br>        header_behavior = string<br>        headers = optional(list(object({<br>          items = set(string)<br>        })), [])<br>      }))<br>      query_strings_config = list(object({<br>        query_string_behavior = string<br>        query_strings = optional(list(object({<br>          items = set(string)<br>        })), [])<br>      }))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_cache_policy_id"></a> [cache\_policy\_id](#input\_cache\_policy\_id) | n/a | `string` | `null` | no |
| <a name="input_continuous_deployment_policy"></a> [continuous\_deployment\_policy](#input\_continuous\_deployment\_policy) | n/a | <pre>list(object({<br>    id      = number<br>    enabled = bool<br>    staging_distribution_dns_names = list(object({<br>      quantity = number<br>      items    = optional(set(string))<br>    }))<br>    traffic_config = list(object({<br>      type = string<br>      single_header_config = optional(list(object({<br>        header = string<br>        value  = string<br>      })), [])<br>      single_weight_config = optional(list(object({<br>        weight = string<br>        session_stickiness_config = optional(list(object({<br>          idle_ttl    = number<br>          maximum_ttl = number<br>        })), [])<br>      })), [])<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_distribution"></a> [distribution](#input\_distribution) | n/a | <pre>list(object({<br>    id                              = number<br>    enabled                         = bool<br>    aliases                         = optional(set(string))<br>    comment                         = optional(string)<br>    continuous_deployment_policy_id = optional(any)<br>    default_root_object             = optional(string)<br>    http_version                    = optional(string)<br>    id                              = optional(string)<br>    is_ipv6_enabled                 = optional(bool)<br>    price_class                     = optional(string)<br>    retain_on_delete                = optional(string)<br>    staging                         = optional(bool)<br>    tags                            = optional(map(string))<br>    wait_for_deployment             = optional(bool)<br>    web_acl_id                      = optional(string)<br>    custom_error_response = optional(list(object({<br>      error_code            = number<br>      error_caching_min_ttl = optional(number)<br>      response_code         = optional(number)<br>      response_page_path    = optional(string)<br>    })), [])<br>    default_cache_behavior = list(object({<br>      allowed_methods           = list(string)<br>      cached_methods            = list(string)<br>      target_origin_id          = string<br>      viewer_protocol_policy    = optional(string)<br>      cache_policy_id           = optional(string)<br>      compress                  = optional(bool)<br>      default_ttl               = optional(number)<br>      field_level_encryption_id = optional(string)<br>      max_ttl                   = optional(number)<br>      min_ttl                   = optional(number)<br>      origin_request_policy_id  = optional(string)<br>      realtime_log_config_arn   = optional(string)<br>      smooth_streaming          = optional(bool)<br>      trusted_signers           = optional(list(string))<br>      forwarded_values = optional(list(object({<br>        query_string            = string<br>        headers                 = optional(list(string))<br>        query_string_cache_keys = optional(list(string))<br>        cookies = list(object({<br>          forward           = optional(string)<br>          whitelisted_names = optional(list(string))<br>        }))<br>      })), [])<br>      function_association = optional(list(object({<br>        event_type   = optional(string)<br>        function_arn = optional(string)<br>      })), [])<br>      lambda_function_association = optional(list(object({<br>        lambda_arn = optional(string)<br>        event_type = optional(string)<br>      })), [])<br>    }))<br>    logging_config = optional(list(object({<br>      bucket          = string<br>      include_cookies = optional(bool)<br>      prefix          = optional(string)<br>    })), [])<br>    ordered_cache_behavior = optional(list(object({<br>      allowed_methods        = list(string)<br>      cached_methods         = list(string)<br>      path_pattern           = optional(string)<br>      target_origin_id       = optional(string)<br>      viewer_protocol_policy = optional(string)<br>    })), [])<br>    origin = optional(list(object({<br>      domain_name = string<br>      origin_id   = string<br>      origin_path = string<br>      custom_header = optional(list(object({<br>        name  = optional(string)<br>        value = optional(string)<br>      })), [])<br>      custom_origin_config = optional(list(object({<br>        http_port                = number<br>        https_port               = number<br>        origin_protocol_policy   = string<br>        origin_ssl_protocols     = list(string)<br>        origin_keepalive_timeout = optional(number)<br>        origin_read_timeout      = optional(number)<br>      })), [])<br>      s3_origin_config = optional(list(object({<br>        origin_access_identity = string<br>      })), [])<br>    })), [])<br>    origin_group = optional(list(object({<br>      origin_id = string<br>      failover_criteria = optional(list(object({<br>        status_codes = list(number)<br>      })), [])<br>      member = list(object({<br>        origin_id = string<br>      }))<br>    })), [])<br>    restrictions = optional(list(object({<br>      geo_restriction = list(object({<br>        restriction_type = string<br>        locations        = optional(list(string))<br>      }))<br>    })), [])<br>    viewer_certificate = optional(list(object({<br>      acm_certificate_arn            = optional(string)<br>      cloudfront_default_certificate = optional(bool)<br>      iam_certificate_id             = optional(string)<br>      minimum_protocol_version       = optional(string)<br>      ssl_support_method             = optional(string)<br>    })), [])<br>  }))</pre> | `[]` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | n/a | `string` | `null` | no |
| <a name="input_field_level_encryption_config"></a> [field\_level\_encryption\_config](#input\_field\_level\_encryption\_config) | n/a | <pre>list(object({<br>    id      = number<br>    comment = optional(string)<br>    content_type_profile_config = list(object({<br>      forward_when_content_type_is_unknown = bool<br>      content_type_profiles = list(object({<br>        items = optional(list(object({<br>          content_type = string<br>          format       = string<br>          profile_id   = optional(string)<br>        })))<br>      }))<br>    }))<br>    query_arg_profile_config = list(object({<br>      forward_when_query_arg_profile_is_unknown = bool<br>      query_arg_profiles = list(object({<br>        items = list(object({<br>          query_arg  = string<br>          profile_id = string<br>        }))<br>      }))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_function_arn"></a> [function\_arn](#input\_function\_arn) | n/a | `string` | `null` | no |
| <a name="input_iam_certificate_id"></a> [iam\_certificate\_id](#input\_iam\_certificate\_id) | n/a | `string` | `null` | no |
| <a name="input_lambda_arn"></a> [lambda\_arn](#input\_lambda\_arn) | n/a | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_target_origin_id"></a> [target\_origin\_id](#input\_target\_origin\_id) | n/a | `string` | `null` | no |
| <a name="input_web_acl_id"></a> [web\_acl\_id](#input\_web\_acl\_id) | n/a | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cache_policy_default_ttl"></a> [cache\_policy\_default\_ttl](#output\_cache\_policy\_default\_ttl) | n/a |
| <a name="output_cache_policy_id"></a> [cache\_policy\_id](#output\_cache\_policy\_id) | n/a |
| <a name="output_cache_policy_name"></a> [cache\_policy\_name](#output\_cache\_policy\_name) | n/a |
| <a name="output_continuous_deployment_policy_enabled"></a> [continuous\_deployment\_policy\_enabled](#output\_continuous\_deployment\_policy\_enabled) | n/a |
| <a name="output_continuous_deployment_policy_etag"></a> [continuous\_deployment\_policy\_etag](#output\_continuous\_deployment\_policy\_etag) | n/a |
| <a name="output_continuous_deployment_policy_id"></a> [continuous\_deployment\_policy\_id](#output\_continuous\_deployment\_policy\_id) | n/a |
| <a name="output_continuous_deployment_policy_last_modified_time"></a> [continuous\_deployment\_policy\_last\_modified\_time](#output\_continuous\_deployment\_policy\_last\_modified\_time) | n/a |
| <a name="output_distribution_arn"></a> [distribution\_arn](#output\_distribution\_arn) | n/a |
| <a name="output_distribution_domain_name"></a> [distribution\_domain\_name](#output\_distribution\_domain\_name) | n/a |
| <a name="output_distribution_etag"></a> [distribution\_etag](#output\_distribution\_etag) | n/a |
| <a name="output_distribution_id"></a> [distribution\_id](#output\_distribution\_id) | n/a |
| <a name="output_distribution_status"></a> [distribution\_status](#output\_distribution\_status) | n/a |
| <a name="output_field_level_encryption_config_comment"></a> [field\_level\_encryption\_config\_comment](#output\_field\_level\_encryption\_config\_comment) | n/a |
| <a name="output_field_level_encryption_config_etag"></a> [field\_level\_encryption\_config\_etag](#output\_field\_level\_encryption\_config\_etag) | n/a |
| <a name="output_field_level_encryption_config_id"></a> [field\_level\_encryption\_config\_id](#output\_field\_level\_encryption\_config\_id) | n/a |
