FROM node:9.6.1 as builder

ENV PATH /usr/src/app/node_modules/.bin:$PATH

RUN mkdir /usr/src/app
WORKDIR /usr/src/app

RUN npm install react-scripts -g --silent
RUN npm install --global gatsby-cli
RUN npm install -g yarn

RUN which yarn

RUN mkdir /usr/src/app/site

WORKDIR /usr/src/app/site
COPY ./site/package.json /usr/src/app/site/package.json
RUN yarn install

COPY . /usr/src/app

WORKDIR /usr/src/app/site
RUN gatsby build

FROM nginx:1.13.9-alpine

RUN rm -rf /etc/nginx/conf.d

COPY conf /etc/nginx

COPY --from=builder /usr/src/app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
