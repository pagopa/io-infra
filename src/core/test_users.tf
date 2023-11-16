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
  test_users_fast_login_load_test = [
    "LVTEST00A00A000X",
    "LVTEST00A00A001X",
    "LVTEST00A00A002X",
    "LVTEST00A00A003X",
    "LVTEST00A00A004X",
    "LVTEST00A00A005X",
    "LVTEST00A00A006X",
    "LVTEST00A00A007X",
    "LVTEST00A00A008X",
    "LVTEST00A00A009X",
    "LVTEST00A00A010X",
    "LVTEST00A00A011X",
    "LVTEST00A00A012X",
    "LVTEST00A00A013X",
    "LVTEST00A00A014X",
    "LVTEST00A00A015X",
    "LVTEST00A00A016X",
    "LVTEST00A00A017X",
    "LVTEST00A00A018X",
    "LVTEST00A00A019X",
    "LVTEST00A00A020X",
    "LVTEST00A00A021X",
    "LVTEST00A00A022X",
    "LVTEST00A00A023X",
    "LVTEST00A00A024X",
    "LVTEST00A00A025X",
    "LVTEST00A00A026X",
    "LVTEST00A00A027X",
    "LVTEST00A00A028X",
    "LVTEST00A00A029X",
    "LVTEST00A00A030X",
    "LVTEST00A00A031X",
    "LVTEST00A00A032X",
    "LVTEST00A00A033X",
    "LVTEST00A00A034X",
    "LVTEST00A00A035X",
    "LVTEST00A00A036X",
    "LVTEST00A00A037X",
    "LVTEST00A00A038X",
    "LVTEST00A00A039X",
    "LVTEST00A00A040X",
    "LVTEST00A00A041X",
    "LVTEST00A00A042X",
    "LVTEST00A00A043X",
    "LVTEST00A00A044X",
    "LVTEST00A00A045X",
    "LVTEST00A00A046X",
    "LVTEST00A00A047X",
    "LVTEST00A00A048X",
    "LVTEST00A00A049X",
    "LVTEST00A00A050X",
    "LVTEST00A00A051X",
    "LVTEST00A00A052X",
    "LVTEST00A00A053X",
    "LVTEST00A00A054X",
    "LVTEST00A00A055X",
    "LVTEST00A00A056X",
    "LVTEST00A00A057X",
    "LVTEST00A00A058X",
    "LVTEST00A00A059X",
    "LVTEST00A00A060X",
    "LVTEST00A00A061X",
    "LVTEST00A00A062X",
    "LVTEST00A00A063X",
    "LVTEST00A00A064X",
    "LVTEST00A00A065X",
    "LVTEST00A00A066X",
    "LVTEST00A00A067X",
    "LVTEST00A00A068X",
    "LVTEST00A00A069X",
    "LVTEST00A00A070X",
    "LVTEST00A00A071X",
    "LVTEST00A00A072X",
    "LVTEST00A00A073X",
    "LVTEST00A00A074X",
    "LVTEST00A00A075X",
    "LVTEST00A00A076X",
    "LVTEST00A00A077X",
    "LVTEST00A00A078X",
    "LVTEST00A00A079X",
    "LVTEST00A00A080X",
    "LVTEST00A00A081X",
    "LVTEST00A00A082X",
    "LVTEST00A00A083X",
    "LVTEST00A00A084X",
    "LVTEST00A00A085X",
    "LVTEST00A00A086X",
    "LVTEST00A00A087X",
    "LVTEST00A00A088X",
    "LVTEST00A00A089X",
    "LVTEST00A00A090X",
    "LVTEST00A00A091X",
    "LVTEST00A00A092X",
    "LVTEST00A00A093X",
    "LVTEST00A00A094X",
    "LVTEST00A00A095X",
    "LVTEST00A00A096X",
    "LVTEST00A00A097X",
    "LVTEST00A00A098X",
    "LVTEST00A00A099X"
  ]

  # All previous sets, ensembled
  test_users = join(",",
    flatten([
      local.test_users_internal,
      local.test_users_internal_load,
      local.test_users_store_review,
      local.test_users_eu_covid_cert,
      local.test_users_fast_login_load_test
      ]
    )
  )

  test_users_internal_flat = join(",",
    flatten([local.test_users_internal])
  )

  test_users_internal_load_flat = join(",",
    flatten([local.test_users_internal_load])
  )

  test_users_store_review_flat = join(",",
    flatten([local.test_users_store_review])
  )

  test_users_eu_covid_cert_flat = join(",",
    flatten([local.test_users_eu_covid_cert])
  )

}
