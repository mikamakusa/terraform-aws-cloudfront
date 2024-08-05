variable "tags" {
  type    = map(string)
  default = {}
}

variable "web_acl_id" {
  type    = string
  default = null
}

variable "target_origin_id" {
  type    = string
  default = null
}

variable "cache_policy_id" {
  type    = string
  default = null
}

variable "function_arn" {
  type    = string
  default = null
}

variable "lambda_arn" {
  type    = string
  default = null
}

variable "domain_name" {
  type    = string
  default = null
}

variable "acm_certificate_arn" {
  type    = string
  default = null
}

variable "iam_certificate_id" {
  type    = string
  default = null
}

variable "cache_policy" {
  type = list(object({
    id          = number
    name        = string
    comment     = optional(string)
    default_ttl = optional(number)
    max_ttl     = optional(number)
    min_ttl     = optional(number)
    parameters = list(object({
      enable_accept_encoding_brotli = optional(bool)
      enable_accept_encoding_gzip   = optional(bool)
      cookies_config = list(object({
        cookie_behavior = string
        cookies = optional(list(object({
          items = set(string)
        })), [])
      }))
      headers_config = list(object({
        header_behavior = string
        headers = optional(list(object({
          items = set(string)
        })), [])
      }))
      query_strings_config = list(object({
        query_string_behavior = string
        query_strings = optional(list(object({
          items = set(string)
        })), [])
      }))
    }))
  }))
  default = []

  validation {
    condition = length([
      for a in var.cache_policy : true if contains(["none", "whitelist", "allExcept", "all"], a.parameters.cookies_config.cookie_behavior)
    ]) == length(var.cache_policy)
    error_message = "Valid values are none, whitelist, allExcept, and all."
  }

  validation {
    condition = length([
      for b in var.cache_policy : true if contains(["none", "whitelist"], b.parameters.headers_config.header_behavior)
    ]) == length(var.cache_policy)
    error_message = "Valid values are none and whitelist."
  }

  validation {
    condition = length([
      for c in var.cache_policy : true if contains(["none", "whitelist", "allExcept", "all"], c.parameters.query_strings_config.query_string_behavior)
    ]) == length(var.cache_policy)
    error_message = "Valid values are none, whitelist, allExcept, and all."
  }
}

variable "continuous_deployment_policy" {
  type = list(object({
    id      = number
    enabled = bool
    staging_distribution_dns_names = list(object({
      quantity = number
      items    = optional(set(string))
    }))
    traffic_config = list(object({
      type = string
      single_header_config = optional(list(object({
        header = string
        value  = string
      })), [])
      single_weight_config = optional(list(object({
        weight = string
        session_stickiness_config = optional(list(object({
          idle_ttl    = number
          maximum_ttl = number
        })), [])
      })), [])
    }))
  }))
  default = []

  validation {
    condition = length([
      for a in var.continuous_deployment_policy : true if contains(["SingleWeight", "SingleHeader"], a.traffic_config.type)
    ]) == length(var.continuous_deployment_policy)
    error_message = "Valid values are SingleWeight and SingleHeader."
  }

  validation {
    condition = length([
      for b in var.continuous_deployment_policy : true if b.traffic_config.single_weight_config.weight >= 0 && b.traffic_config.single_weight_config.weight <= 15
    ]) == length(var.continuous_deployment_policy)
    error_message = "The percentage of traffic to send to a staging distribution, expressed as a decimal number between 0 and .15."
  }

  validation {
    condition = length([
      for c in var.continuous_deployment_policy : true if c.traffic_config.single_weight_config.session_stickiness_config.idle_ttl >= 300 && c.traffic_config.single_weight_config.session_stickiness_config.idle_ttl <= 3600
    ]) == length(var.continuous_deployment_policy)
    error_message = "Valid values are 300 – 3600 (5–60 minutes). The value must be less than or equal to maximum_ttl."
  }

  validation {
    condition = length([
      for d in var.continuous_deployment_policy : true if d.traffic_config.single_weight_config.session_stickiness_config.maximum_ttl >= 300 && d.traffic_config.single_weight_config.session_stickiness_config.maximum_ttl <= 3600
    ]) == length(var.continuous_deployment_policy)
    error_message = "Valid values are 300 – 3600 (5–60 minutes). The value must be greater than or equal to idle_ttl."
  }
}

variable "distribution" {
  type = list(object({
    id                              = number
    enabled                         = bool
    aliases                         = optional(set(string))
    comment                         = optional(string)
    continuous_deployment_policy_id = optional(any)
    default_root_object             = optional(string)
    http_version                    = optional(string)
    id                              = optional(string)
    is_ipv6_enabled                 = optional(bool)
    price_class                     = optional(string)
    retain_on_delete                = optional(string)
    staging                         = optional(bool)
    tags                            = optional(map(string))
    wait_for_deployment             = optional(bool)
    web_acl_id                      = optional(string)
    custom_error_response = optional(list(object({
      error_code            = number
      error_caching_min_ttl = optional(number)
      response_code         = optional(number)
      response_page_path    = optional(string)
    })), [])
    default_cache_behavior = list(object({
      allowed_methods           = list(string)
      cached_methods            = list(string)
      target_origin_id          = string
      viewer_protocol_policy    = optional(string)
      cache_policy_id           = optional(string)
      compress                  = optional(bool)
      default_ttl               = optional(number)
      field_level_encryption_id = optional(string)
      max_ttl                   = optional(number)
      min_ttl                   = optional(number)
      origin_request_policy_id  = optional(string)
      realtime_log_config_arn   = optional(string)
      smooth_streaming          = optional(bool)
      trusted_signers           = optional(list(string))
      forwarded_values = optional(list(object({
        query_string            = string
        headers                 = optional(list(string))
        query_string_cache_keys = optional(list(string))
        cookies = list(object({
          forward           = optional(string)
          whitelisted_names = optional(list(string))
        }))
      })), [])
      function_association = optional(list(object({
        event_type   = optional(string)
        function_arn = optional(string)
      })), [])
      lambda_function_association = optional(list(object({
        lambda_arn = optional(string)
        event_type = optional(string)
      })), [])
    }))
    logging_config = optional(list(object({
      bucket          = string
      include_cookies = optional(bool)
      prefix          = optional(string)
    })), [])
    ordered_cache_behavior = optional(list(object({
      allowed_methods        = list(string)
      cached_methods         = list(string)
      path_pattern           = optional(string)
      target_origin_id       = optional(string)
      viewer_protocol_policy = optional(string)
    })), [])
    origin = optional(list(object({
      domain_name = string
      origin_id   = string
      origin_path = string
      custom_header = optional(list(object({
        name  = optional(string)
        value = optional(string)
      })), [])
      custom_origin_config = optional(list(object({
        http_port                = number
        https_port               = number
        origin_protocol_policy   = string
        origin_ssl_protocols     = list(string)
        origin_keepalive_timeout = optional(number)
        origin_read_timeout      = optional(number)
      })), [])
      s3_origin_config = optional(list(object({
        origin_access_identity = string
      })), [])
    })), [])
    origin_group = optional(list(object({
      origin_id = string
      failover_criteria = optional(list(object({
        status_codes = list(number)
      })), [])
      member = list(object({
        origin_id = string
      }))
    })), [])
    restrictions = optional(list(object({
      geo_restriction = list(object({
        restriction_type = string
        locations        = optional(list(string))
      }))
    })), [])
    viewer_certificate = optional(list(object({
      acm_certificate_arn            = optional(string)
      cloudfront_default_certificate = optional(bool)
      iam_certificate_id             = optional(string)
      minimum_protocol_version       = optional(string)
      ssl_support_method             = optional(string)
    })), [])
  }))
  default = []

  validation {
    condition = length([
      for a in var.distribution : true if contains(["http1.1", "http2", "http2and3"], a.http_version)
    ]) == length(var.distribution)
    error_message = "Allowed values are http1.1, http2, http2and3 and http3."
  }

  validation {
    condition = length([
      for b in var.distribution : true if contains(["PriceClass_All", "PriceClass_200", "PriceClass_100"], b.price_class)
    ]) == length(var.distribution)
    error_message = "One of PriceClass_All, PriceClass_200, PriceClass_100."
  }

  validation {
    condition = length([
      for c in var.distribution : true if contains(["allow-all", "https-only", "redirect-o-https"], c.default_cache_behavior.viewer_protocol_policy)
    ]) == length(var.distribution)
    error_message = "One of allow-all, https-only, or redirect-to-https."
  }

  validation {
    condition = length([
      for d in var.distribution : true if contains(["viewer-request", "origin-request", "viewer-response", "origin-response"], d.default_cache_behavior.lambda_function_association.event_type)
    ]) == length(var.distribution)
    error_message = "Valid values: viewer-request, origin-request, viewer-response, origin-response."
  }

  validation {
    condition = length([
      for e in var.distribution : true if contains(["viewer-request", "viewer-response"], e.default_cache_behavior.function_association.event_type)
    ]) == length(var.distribution)
    error_message = "Valid values: viewer-request or viewer-response."
  }

  validation {
    condition = length([
      for f in var.distribution : true if contains(["all", "none", "whitelist"], f.default_cache_behavior.forwarded_values.cookies.forward)
    ]) == length(var.distribution)
    error_message = "Valid values: all, none or whitelist."
  }

  validation {
    condition = length([
      for f in var.distribution : true if contains(["http-only", "https-only", "match-viewer"], f.origin.custom_origin_config.origin_protocol_policy)
    ]) == length(var.distribution)
    error_message = "Valid values: http-only, https-only or match-viewer."
  }

  validation {
    condition = length([
      for g in var.distribution : true if contains(["SSLv3", "TLSv1", "TLSv1.1"], g.origin.custom_origin_config.origin_ssl_protocols)
    ]) == length(var.distribution)
    error_message = "Valid values: SSLv3, TLSv1 or TLSv1.1."
  }

  validation {
    condition = length([
      for h in var.distribution : true if contains(["vip", "sni-only", "statis-ip"], h.viewer_certificate.ssl_support_method)
    ]) == length(var.distribution)
    error_message = "One of vip, sni-only, or static-ip."
  }
}

variable "field_level_encryption_config" {
  type = list(object({
    id      = number
    comment = optional(string)
    content_type_profile_config = list(object({
      forward_when_content_type_is_unknown = bool
      content_type_profiles = list(object({
        items = optional(list(object({
          content_type = string
          format       = string
          profile_id   = optional(string)
        })))
      }))
    }))
    query_arg_profile_config = list(object({
      forward_when_query_arg_profile_is_unknown = bool
      query_arg_profiles = list(object({
        items = list(object({
          query_arg  = string
          profile_id = string
        }))
      }))
    }))
  }))
  default = []
}