FROM node:20
WORKDIR /app
COPY package.json ./
RUN npm i
COPY . .
RUN npm run build --prod
FROM nginx:alpine
COPY --from=builder /dist/lazy-pro /usr/share/nginx/html
EXPOSE 80
CMD [ "nginx","-g","daemon off;" ]