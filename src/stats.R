library(lubridate)

# Subset the dataset for these statistics functions
stats._subset <- function(
  data,
  the.uid,
  start = as.POSIXct('2012-01-01'),
  end = as.POSIXct(Sys.Date())
) {
  # Inclusive at start datetime, exclusive at end datetime
  subset(data, uid == the.uid) # & datetime >= start & datetime < end)
}

# Time spent on Facebook by user within a time span, assuming that the
# data include only one user
stats.total.duration <- function(status) {
  # Previous datetime
  # For the last one, the previous is the same as the current; this makes it
  # easy to ignore that one while not messing up types.
  status$datetime_next <- c(status$datetime[-1], tail(status$datetime, n=1))

  # Duration of the status
  status$interval <- interval(status$datetime, status$datetime_next)
  status$duration <- as.duration(status$interval)

  # Only statuses of "avail", indicating the start of onlineness
  status.avail <- subset(status, status == 'avail')

  # Dunno why I need to turn this back into seconds
  total_duration <- dseconds(sum(status.avail$duration)) 

  total_duration
}






# Subset by user and time span, then pick out the interesting columns.
# status <- stats._subset(data, uid, start, end)[c('datetime', 'status')]
fb.time <- ddply(log.status, 'uid', function(df) {
   c(total_duration = stats.total.duration(df))
})
fb.time <- join(fb.time, nick.data.frame)
fb.time <- fb.time[order(fb.time$total_duration),]
fb.time$total_duration <- dseconds(fb.time$total_duration)

# Just for Mike
fb.time.mike <- stats.time.on.fb(subset(log.status, uid == 'xmpp:-1374361540@chat.facebook.com'))

