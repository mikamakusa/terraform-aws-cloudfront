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
  }
}