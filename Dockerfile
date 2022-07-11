FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install --loglevel verbose
RUN mkdir node_modules/.cache && chmod -R 777 node_modules/.cache
RUN npm i -D --exact jest-watch-typeahead@0.6.5
COPY . .
CMD ["npm", "run", "build"]

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
