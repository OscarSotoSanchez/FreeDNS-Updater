FROM alpine:3.7

# Install curl
RUN apk --no-cache add curl

# Copy shell files
COPY freedns.sh /usr/bin
COPY crontab /var/spool/cron/crontabs/root

# Create folder to mount volumes
RUN mkdir /var/tmp/freedns

# Run programn every 5 minutes
CMD test -f "/var/tmp/freedns/freedns_tokens" && /usr/bin/freedns.sh && crond -l 2 -f