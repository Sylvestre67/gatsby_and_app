FROM node:9.10.0 as builder

ENV PATH /usr/src/app/node_modules/.bin:$PATH

RUN mkdir /usr/src/app
WORKDIR /usr/src/app

RUN npm install react-scripts -g --silent
RUN npm install --global gatsby-cli
RUN which yarn

RUN mkdir /usr/src/app/site
WORKDIR /usr/src/app/site

COPY ./site/package.json /usr/src/app/site/package.json
RUN yarn install

RUN mkdir /usr/src/app/alpha
WORKDIR /usr/src/app/alpha

COPY ./alpha/package.json /usr/src/app/alpha/package.json
RUN yarn install

RUN mkdir /usr/src/app/beta
WORKDIR /usr/src/app/beta

COPY ./beta/package.json /usr/src/app/beta/package.json
RUN yarn install

COPY . /usr/src/app

WORKDIR /usr/src/app/site
RUN gatsby build

WORKDIR /usr/src/app/alpha
RUN yarn build

WORKDIR /usr/src/app/beta
RUN yarn build

FROM nginx:1.13.9-alpine

RUN rm -rf /etc/nginx/conf.d

COPY conf /etc/nginx

COPY --from=builder /usr/src/app/site/public /usr/share/nginx/html/site

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
