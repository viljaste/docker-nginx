# docker-nginx

## Run the container

Using the `docker` command:

    CONTAINER="nginxdata" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -v /nginx/data \
      -v /nginx/ssl/certs \
      -v /nginx/ssl/private \
      simpledrupalcloud/data:latest

    CONTAINER="nginx" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 80:80 \
      -p 443:443 \
      --volumes-from nginxdata \
      -e SERVER_NAME="localhost" \
      -d \
      simpledrupalcloud/nginx:latest

Using the `fig` command

    TMP="$(mktemp -d)" \
      && git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-nginx.git "${TMP}" \
      && cd "${TMP}" \
      && sudo fig up

## Build the image

    TMP="$(mktemp -d)" \
      && git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-nginx.git "${TMP}" \
      && cd "${TMP}" \
      && sudo docker build -t simpledrupalcloud/nginx:latest . \
      && cd -

## Back up Nginx data

    sudo docker run \
      --rm \
      --volumes-from nginxdata \
      -v $(pwd):/backup \
      simpledrupalcloud/data:latest tar czvf /backup/nginxdata.tar.gz /nginx/data

## Restore Nginx data from a backup

    sudo docker run \
      --rm \
      --volumes-from nginxdata \
      -v $(pwd):/backup \
      simpledrupalcloud/data:latest tar xzvf /backup/nginxdata.tar.gz

## License

**MIT**
