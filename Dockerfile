FROM node:16-alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
WORKDIR /usr/share/nginx/html
RUN rm -rf *
COPY --from=builder /app/build .
EXPOSE 80
ENTRYPOINT [ "nginx", "-g", "daemon off;"]