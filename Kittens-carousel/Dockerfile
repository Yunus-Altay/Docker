FROM nginx
RUN apt-get update -y
WORKDIR /usr/share/nginx/html/
RUN rm ./index.html
COPY . /usr/share/nginx/html
EXPOSE 80