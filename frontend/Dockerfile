# build
FROM node:14.17.3 as build
WORKDIR /usr/src/app
COPY . .
RUN npm install karma@6.3.20 && npm install && npm run build

# release check3
FROM nginxproxy/nginx-proxy
COPY --from=build /usr/src/app/dist/frontend /usr/share/nginx/html
COPY nginx.tmpl /app/nginx.tmpl
EXPOSE 80