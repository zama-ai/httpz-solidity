FROM node:20-slim

# Set the working directory
WORKDIR /app

# Copy only necessary files for npm install
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install && \
    npm cache clean --force

# Copy the application files
COPY .env.example.deployment *.sh *.ts tsconfig.json ./
COPY lib ./lib/
COPY tasks ./tasks/
COPY gateway ./gateway/

RUN chmod +x *.sh
