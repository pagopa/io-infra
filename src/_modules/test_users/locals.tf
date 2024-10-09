locals {
  # A list of fiscal codes to be used by internal team for functional, e2e tests on IO
  test_users_internal = [
    "EEEEEE00E00E000A",
    "EEEEEE00E00E000B",
    "EEEEEE00E00E000C",
    "EEEEEE00E00E000D",
    "EEEEEE00E00E000E",
  ]
  # A list of fiscal codes to be used by internal team for load tests on IO
  test_users_internal_load = [
    "AAAAAA00A00A000C",
    "AAAAAA00A00A000D",
    "AAAAAA00A00A000E",
  ]
  # A list of fiscal codes to be used by app stores to review IO App
  test_users_store_review = [
    "AAAAAA00A00A000B",
  ]
  # A list of fiscal codes to be used to test EU Covid Certificate initiative on IO
  test_users_eu_covid_cert = [
    "PRVPRV25A01H501B",
    "XXXXXP25A01H501L",
    "YYYYYP25A01H501K",
    "KKKKKP25A01H501U",
    "QQQQQP25A01H501S",
    "WWWWWP25A01H501A",
    "ZZZZZP25A01H501J",
    "JJJJJP25A01H501X",
    "GGGGGP25A01H501Z",
  ]

  # A list of fiscal code to be uset to execute load test for Fast Login initiative on IO
  test_users_fast_login_load_test = concat([
    for i in range(0, 1000) : format("LVTEST00A00A%03dX", i)
    ], [
    for i in range(0, 1000) : format("LVTEST00A00B%03dX", i)
  ])

  # A list of fiscal code to be used to test for Unique Email Enforcement initiative on IO
  test_users_unique_email_test = [
    "UEETST00A00A000X",
    "UEETST00A00A001X",
  ]

  test_users_fast_login_load_test_light = [
    for i in range(0, 200) : format("LVTEST00A00A%03dX", i)
  ]
}