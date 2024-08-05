run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "cloudfront" {
  command = [plan,apply]

  variables {
    cache_policy = [
      {
        id = 0
        name        = "example-policy"
        comment     = "test comment"
        default_ttl = 50
        max_ttl     = 100
        min_ttl     = 1
        parameters = [
          {
            cookies_config = [
              {
                cookie_behavior = "whitelist"
              }
            ]
            headers_config = [
              {
                header_behavior = "whitelist"
              }
            ]
            query_strings_config = [
              {
                query_string_behavior = "whitelist"
              }
            ]
          }
        ]
      }
    ]
    continuous_deployment_policy = [
      {
        id      = 0
        enabled = true
        staging_distribution_dns_names = [
          {
            items_id = [aws_cloudfront_distribution.staging.domain_name]
            quantity = 1
          }
        ]
        traffic_config = [
          {
            type = "SingleWeight"
            single_weight_config = [
              {
                weight = "0.01"
              }
            ]
          }
        ]
      }
    ]
    distribution = [
      {
        id = 0
        origin = [
          {
            domain_name = aws_s3_bucket.primary.bucket_regional_domain_name
            origin_id   = "myS3Origin"
            s3_origin_config = [
              {
                origin_access_identity = 0
              }
            ]
          }
        ]
        enabled             = true
        is_ipv6_enabled     = true
        comment             = "Some comment"
        default_root_object = "index.html"
        default_cache_behavior = [
          {
            cache_policy_id  = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
            allowed_methods = ["GET", "HEAD", "OPTIONS"]
            target_origin_id = local.s3_origin_id
          }
        ]
        restrictions = [
          {
            geo_restriction = [
              {
                restriction_type = "whitelist"
                locations = ["US", "CA", "GB", "DE"]
              }
            ]
          }
        ]
        viewer_certificate = [
          {
            cloudfront_default_certificate = true
          }
        ]
      }
    ]
    origin_access_identity = [
      {
        id = 0
        comment = "blablabla"
      }
    ]
  }
}