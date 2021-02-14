FROM node:lts-alpine as compile-image
WORKDIR /app

COPY ["package.json", "yarn.lock", "./"]
RUN yarn

COPY . ./
RUN yarn build:prod

# ----------- #

FROM nginx:alpine
#RUN rm -rf /usr/share/nginx/html/*
COPY --from=compile-image /app/dist/frontend /var/www/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
