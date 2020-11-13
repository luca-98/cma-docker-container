### STAGE 1 ###
FROM node:12.18.4-alpine AS build

RUN mkdir /code
WORKDIR /code

COPY cma-client/package.json /code/package.json
RUN yarn install

COPY cma-client/. /code
RUN npm run build_prod

### STAGE 2 ###
FROM nginx:1.19.3-alpine

RUN rm -rf /usr/share/nginx/html/*
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /code/dist/cma-client /usr/share/nginx/html