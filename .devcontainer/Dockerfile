# syntax=docker/dockerfile:1

ARG VARIANT="20"
FROM mcr.microsoft.com/vscode/devcontainers/javascript-node:0-${VARIANT}

# Install SAP CAP development tools and Java 17
RUN apt-get update && apt-get -y install --no-install-recommends \
    curl \
    git \
    sqlite3 \
    openjdk-17-jdk \
    maven

# Explicitly create bashrc if it doesn't exist
RUN touch /etc/bash.bashrc

# Set up environment variables for Java and Maven
RUN echo '# Java and Maven environment setup' >> /etc/bash.bashrc && \
    echo 'export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))' >> /etc/bash.bashrc && \
    echo 'export PATH=$PATH:$JAVA_HOME/bin:/usr/share/maven/bin' >> /etc/bash.bashrc

# Create a verification script
RUN echo '#!/bin/bash' > /usr/local/bin/verify-tools && \
    echo 'echo "Verifying development tools:"' >> /usr/local/bin/verify-tools && \
    echo 'echo "Java version: $(java --version 2>&1)"' >> /usr/local/bin/verify-tools && \
    echo 'echo "Maven version: $(mvn --version 2>&1)"' >> /usr/local/bin/verify-tools && \
    echo 'echo "Node version: $(node --version 2>&1)"' >> /usr/local/bin/verify-tools && \
    echo 'echo "CDS version: $(cds --version 2>&1 || echo \"CDS not installed\")"' >> /usr/local/bin/verify-tools && \
    chmod +x /usr/local/bin/verify-tools

# Create a setup script that will be available if manual setup is needed
RUN echo '#!/bin/bash' > /usr/local/bin/setup-java && \
    echo 'sudo apt-get update && sudo apt-get install -y openjdk-17-jdk maven' >> /usr/local/bin/setup-java && \
    echo 'export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))' >> /usr/local/bin/setup-java && \
    echo 'echo "export JAVA_HOME=$JAVA_HOME" >> ~/.bashrc' >> /usr/local/bin/setup-java && \
    echo 'echo "export PATH=\$PATH:\$JAVA_HOME/bin:/usr/share/maven/bin" >> ~/.bashrc' >> /usr/local/bin/setup-java && \
    chmod +x /usr/local/bin/setup-java

# Install SAP CAP SDK globally
USER node
RUN npm install -g @sap/cds-dk
WORKDIR /home/node

# Add verification to .bashrc to run when shell starts
RUN echo "# Run verification on startup" >> ~/.bashrc && \
    echo "verify-tools" >> ~/.bashrc