# Step 1: Build the Angular application
FROM node:20.15.0 as build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build --configuration production  
# Updated to use --configuration production

# Step 2: Serve the application using nginx
FROM nginx:alpine

COPY --from=build /app/dist/lazy-pro /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
