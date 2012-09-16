# Subset the dataset for these statistics functions
stats._subset <- function(
  data,
  the.uid,
  start,
  end
) {
  # Inclusive at start datetime, exclusive at end datetime
  subset(data, uid == the.uid) # & datetime >= start & datetime < end)
}

# Time spent on Facebook by user within a time span
stats.time.on.fb <- function(
  data,
  uid,
  start = as.POSIXct('2012-01-01'),
  end = as.POSIXct(Sys.Date()),
  ...
) {
  data.subset <- stats._subset(data, uid, start, end)
  data.subset
}

# stats.time.on.fb(log.status, 'xmpp:-1374361540@chat.facebook.com')
