variable "tags" {
  type    = map(string)
  default = {}
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