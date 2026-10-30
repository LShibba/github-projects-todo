
# Use Python 3.9 as the base image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Install Bash and Git
RUN apt-get update && \
    apt-get install -y --no-install-recommends bash git && \
    rm -rf /var/lib/apt/lists/*

# Copy all repository files into the container
COPY . /app

# Convert Windows line endings to Unix format
RUN sed -i 's/\r$//' /app/entrypoint.sh && \
    sed -i 's/\r$//' /app/update_index.sh

# Make shell scripts executable
RUN chmod +x /app/entrypoint.sh && \
    chmod +x /app/update_index.sh

# Run entrypoint.sh using Bash
ENTRYPOINT ["/bin/bash", "/app/entrypoint.sh"]
