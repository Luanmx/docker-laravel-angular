From nginx
RUN apt-get update
RUN apt-get install iputils-ping -y
RUN  mkdir /usr/share/nginx/html/frontend/
WORKDIR /usr/share/nginx/html/frontend/