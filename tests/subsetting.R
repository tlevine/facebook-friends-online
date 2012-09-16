# The subset should be smaller.
expect_that(
  nrow(stats._subset(
    log.status,
    'xmpp:-1374361540@chat.facebook.com',
    as.POSIXct('2012-01-01'),
    as.POSIXct(Sys.Date())
  )),
  less_than(nrow(log.status))
)
