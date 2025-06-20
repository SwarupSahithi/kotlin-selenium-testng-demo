# Use official Maven image with OpenJDK 17
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Set working directory inside container
WORKDIR /app

# Copy the entire project
COPY . .

# Download dependencies and compile tests (optional)
RUN mvn dependency:resolve

# Install Chrome
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    gnupg \
    unzip \
    && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && apt-get install -y ./google-chrome-stable_current_amd64.deb \
    && rm google-chrome-stable_current_amd64.deb

# Run tests (headless)
CMD mvn test -Dselenium.browser=chrome-headless
