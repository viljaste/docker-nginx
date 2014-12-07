# docker-nginx

## Nginx (STABLE BRANCH)

### Run the container

Using the `docker` command:

    CONTAINER="nginxdata" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -v /nginx/data \
      simpledrupalcloud/data:latest

    CONTAINER="nginx" && sudo docker run \
      --name "${CONTAINER}" \
      -h "${CONTAINER}" \
      -p 80:80 \
      -p 443:443 \
      --volumes-from nginxdata \
      -d \
      simpledrupalcloud/nginx:latest

Using the `fig` command

    TMP="$(mktemp -d)" \
      && git clone http://git.simpledrupalcloud.com/simpledrupalcloud/docker-nginx.git "${TMP}" \
      && cd "${TMP}" \
      && sudo fig up

### Build the image

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
      busybox:latest tar czvf /backup/nginxdata.tar.gz /nginx/data

## Restore Nginx data from a backup

    sudo docker run \
      --rm \
      --volumes-from nginxdata \
      -v $(pwd):/backup \
      busybox:latest tar xzvf /backup/nginxdata.tar.gz

## License

**MIT**
