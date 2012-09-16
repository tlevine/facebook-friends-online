stats._subset <- function(
  data,
  uid,
  start,
  end,
) {
  # Inclusive at start datetime, exclusive at end datetime
  subset(data, uid == uid && datetime => start && datetime < end)
}

stats.time.on.fb <- function(
  data,
  uid,
  start = as.POSIXct('2012-01-01'),
  end = as.POSIXct(Sys.Date()),
  ...
) {
  data.subset <- stats._subset(data, uid, start, end)
}

