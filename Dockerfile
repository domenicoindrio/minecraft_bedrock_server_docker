FROM ubuntu:22.04

WORKDIR /bedrock

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends wget unzip ca-certificates libcurl4  && \
    rm -rf /var/lib/apt/lists/*

# Build argument for Bedrock version
ARG BEDROCK_VERSION

# Download and install Bedrock server using wget
RUN BEDROCK_URL="https://www.minecraft.net/bedrockdedicatedserver/bin-linux/bedrock-server-${BEDROCK_VERSION}.zip" && \
    echo "Downloading $BEDROCK_URL" && \
    wget --https-only \
         --user-agent="Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101 Firefox/128.0" \
         -O bedrock-server.zip "$BEDROCK_URL" && \
    unzip bedrock-server.zip && \
    rm bedrock-server.zip && \
    chmod +x bedrock_server
    
# Copy entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose Bedrock ports
EXPOSE 19132/udp 19133/udp

ENTRYPOINT ["/entrypoint.sh"]