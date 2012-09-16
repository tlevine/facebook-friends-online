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

  # Subset by user and time span, then pick out the interesting columns.
  data <- stats._subset(data, uid, start, end)[c('datetime', 'status')]

  # Previous datetime
  # For the last one, the previous is the same as the current; this makes it
  # easy to ignore that one while not messing up types.
  data$datetime_next <- c(data$datetime[-1], tail(log.status$datetime, n=1))

  # Duration of the status
  data$interval <- interval(data$datetime, data$datetime_next)
  data$duration <- as.duration(data$interval)

  data <- subset(data, status == 'avail')
  data
}

# stats.time.on.fb(log.status, 'xmpp:-1374361540@chat.facebook.com')
