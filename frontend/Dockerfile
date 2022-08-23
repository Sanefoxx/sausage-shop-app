# build
FROM node:14.17.3 as build
WORKDIR /usr/src/app
COPY . .
RUN npm install karma@6.3.20 && npm install && npm run build

# release
FROM node:14.17.3-alpine
WORKDIR /usr/src/app
RUN addgroup --system front && adduser -S -s /bin/false -G front front -D -H
COPY --from=build --chown=front:front /usr/src/app/dist/frontend/ /usr/src/app
RUN npm install -g http-server
EXPOSE 80
USER front
ENTRYPOINT ["http-server", ".", "-p", "80", "--proxy", "http://backend:8080"]
