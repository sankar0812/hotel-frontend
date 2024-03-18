# Stage 1: Development stage
FROM node:14-alpine as development
WORKDIR /hotelfrontend

COPY package.json .
RUN npm install
COPY . .

# Stage 2: Build stage
FROM development as build

RUN npm run build

# Stage 3: Production stage
FROM node:20-alpine as production

WORKDIR /hotelfrontend

COPY --from=build /hotelfrontend/dist ./dist
COPY package.json .


RUN npm install -g http-server
#RUN npm install --only=production

EXPOSE 3000

CMD ["npm", "start"]
