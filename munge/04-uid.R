# Data frame mapping uid to nick
nick.data.frame <- ddply(log.status, 'uid', function(df){nick = df[1,'nick']})
colnames(nick.data.frame)[2] <- 'nick'

# Vector mapping uid to nick
nick.array <- daply(log.status, 'uid', function(df){df[1,'nick']})
