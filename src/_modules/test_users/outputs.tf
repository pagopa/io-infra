
output "users" {
  value = {

    # All previous sets, ensembled
    all = join(",",
      flatten([
        local.test_users_internal,
        local.test_users_internal_load,
        local.test_users_store_review,
        local.test_users_eu_covid_cert,
        local.test_users_fast_login_load_test,
        local.test_users_unique_email_test,
        ]
      )
    )

    internal_flat = join(",",
      flatten([local.test_users_internal])
    )

    internal_load_flat = join(",",
      flatten([local.test_users_internal_load])
    )

    store_review_flat = join(",",
      flatten([local.test_users_store_review])
    )

    eu_covid_cert_flat = join(",",
      flatten([local.test_users_eu_covid_cert])
    )

    light = join(",",
      flatten([
        local.test_users_internal,
        local.test_users_internal_load,
        local.test_users_store_review,
        local.test_users_eu_covid_cert,
        local.test_users_fast_login_load_test_light,
        local.test_users_unique_email_test,
        ]
      )
    )

    unique_email_test = local.test_users_unique_email_test
  }
}
