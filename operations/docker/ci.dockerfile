FROM node:20-slim

# Set the working directory
WORKDIR /app

# Copy only necessary files for npm install
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install && \
    npm cache clean --force

COPY .env.example.deployment ./
COPY lib ./lib/
COPY tasks ./tasks/
COPY gateway ./gateway/
COPY *.sh ./
COPY *.ts ./
COPY tsconfig.json ./

RUN chmod +x *.sh