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

# Set executable permissions and prepare the environment
RUN chmod +x *.sh && \
    cp .env.example.deployment .env && \
    ./precompute-addresses.sh

# Set up environment variables and compile contracts
RUN export PRIVATE_KEY_FHEVM_DEPLOYER=$(grep PRIVATE_KEY_FHEVM_DEPLOYER .env | cut -d '"' -f 2) && \
    export NUM_KMS_SIGNERS=$(grep NUM_KMS_SIGNERS .env | cut -d '"' -f 2) && \
    npx hardhat clean && \
    npx hardhat compile:specific --contract lib && \
    npx hardhat compile:specific --contract gateway
