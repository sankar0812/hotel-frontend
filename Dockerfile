# Stage 1: Build stage
FROM node:20-alpine as build

WORKDIR /app

COPY package.json .

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the application
RUN npm run build

# Stage 2: Create the production image
FROM node:20-alpine
WORKDIR /app

# Copy the built files from the build stage
COPY --from=build /app/dist ./dist
# Expose port 3000
#EXPOSE 8080

COPY package.json .
COPY vite.config.js .
COPY . .

RUN npm install -g http-server

RUN npm install 

EXPOSE 8080

CMD ["http-server", "dist", "-p", "8080"]
