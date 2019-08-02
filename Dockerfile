FROM nginx:1.13.9-alpine

LABEL maintainer="NGINX for non-root platform: OpenShift"

RUN set -x \
        && chmod go+w /var/cache/nginx \
      # && chmod go+w /var/run/nginx.pid \
        && chmod go+w /usr/share/nginx/html/ \
        && sed -i -e '/listen/!b' -e '/80;/!b' -e 's/80;/8080;/' /etc/nginx/conf.d/default.conf \
        #&& sed -i -e '/listen/!b' -e '/80;/!b' -e 's/80;/8080;/' /usr/share/nginx/html/  \
        && sed -i -e '/user/!b' -e '/nginx/!b' -e '/nginx/d' /etc/nginx/nginx.conf \
        #&& sed -i -e '/user/!b' -e '/nginx/!b' -e '/nginx/d' /usr/share/nginx/html/  \
        && sed -i 's!/var/run/nginx.pid!/var/cache/nginx/nginx.pid!g' /etc/nginx/nginx.conf

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/xmlking/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz



#COPY nginx.conf /etc/nginx/conf.d/default.conf
#ADD  nginx.conf etc/nginx/conf.d/
EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
