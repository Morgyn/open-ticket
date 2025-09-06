FROM node:24-alpine AS build
## Build stage

ENV NODE_ENV production

WORKDIR /build

COPY package*.json ./

RUN npm install

FROM node:24-alpine

ENV NODE_ENV production

WORKDIR /app

COPY --from=build /build/node_modules ./node_modules

# Copy everything except inside .dockerignore
COPY . .

# Rename config, database and plugins directories to name-example
RUN mv ./config ./config-example && \
    mv ./database ./database-example && \
    mv ./plugins ./plugins-example

# Make symlinks for volumes
RUN ln -s /config ./config && \
    ln -s /database ./database && \
    ln -s /plugins ./plugins

VOLUME /config
VOLUME /database
VOLUME /plugins

# Set environment to disable npm update notifier
ENV NPM_CONFIG_UPDATE_NOTIFIER=false

# Set entrypoint
ENTRYPOINT [ "/app/docker_entrypoint.sh" ]

# start the server
CMD [ "start" ]