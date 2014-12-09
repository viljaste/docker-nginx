# docker-nginx

## Run the container

Using the `docker` command:

    CONTAINER="nginxdata" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -v /nginx/data \
      simpledrupalcloud/data:dev

    CONTAINER="nginx" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 80:80 \
      -p 443:443 \
      --volumes-from nginxdata \
      -e SERVER_NAME="localhost" \
      -d \
      simpledrupalcloud/nginx:dev

Using the `fig` command

    TMP="$(mktemp -d)" \
      && git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-nginx.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout dev \
      && sudo fig up

## Build the image

    TMP="$(mktemp -d)" \
      && git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-nginx.git "${TMP}" \
      && cd "${TMP}" \
      && git checkout dev \
      && sudo docker build -t simpledrupalcloud/nginx:dev . \
      && cd -

## Back up Nginx data

    sudo docker run \
      --rm \
      --volumes-from nginxdata \
      -v $(pwd):/backup \
      simpledrupalcloud/data:dev tar czvf /backup/nginxdata.tar.gz /nginx/data

## Restore Nginx data from a backup

    sudo docker run \
      --rm \
      --volumes-from nginxdata \
      -v $(pwd):/backup \
      simpledrupalcloud/data:dev tar xzvf /backup/nginxdata.tar.gz

## License

**MIT**
