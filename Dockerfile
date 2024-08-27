# Use the official Nextcloud image as the base image
FROM nextcloud:29

# Define build arguments for PHP settings
ARG PHP_MEMORY_LIMIT=1G
ARG PHP_UPLOAD_LIMIT=5G

# Install ffmpeg and cron
RUN apt-get update && \
    apt-get install -y ffmpeg cron sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add a cron job to run every minute
COPY crontab /etc/cron.d/nextcloud-cron

# Apply permissions for the cron file
RUN chmod 0644 /etc/cron.d/nextcloud-cron

# Apply the cron job
RUN crontab /etc/cron.d/nextcloud-cron

# Configure PHP settings
RUN echo "memory_limit=${PHP_MEMORY_LIMIT}" > /usr/local/etc/php/conf.d/nextcloud.ini && \
    echo "upload_max_filesize=${PHP_UPLOAD_LIMIT}" >> /usr/local/etc/php/conf.d/nextcloud.ini && \
    echo "post_max_size=${PHP_UPLOAD_LIMIT}" >> /usr/local/etc/php/conf.d/nextcloud.ini


# Run cron in the background along with the default CMD
CMD ["sh", "-c", "cron && apache2-foreground"]
