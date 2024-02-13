FROM alpine:3.10

# Install packages
RUN apk update && \
    apk add --no-cache \
    curl jq

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh

# Make script executable
RUN chmod +x /entrypoint.sh

# Execute entrypoint file
ENTRYPOINT ["/entrypoint.sh"]