FROM nginx:alpine

#COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf

WORKDIR /usr/share/nginx/html

COPY dist .