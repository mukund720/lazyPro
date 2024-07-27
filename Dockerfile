# Stage 1: Build the Angular app
FROM node:20 as build-stage
# Set the working directory inside the container
WORKDIR /app
# Copy package.json and package-lock.json for installing dependencies
COPY package*.json ./
# Install the dependencies defined in package.json
RUN npm install
# Copy the rest of the application code to the container
COPY . .
# Build the Angular application for production
RUN npm run build --prod

# Stage 2: Serve the app with Nginx
FROM nginx:alpine as start-stage
# Copy the built Angular app from the build stage to the Nginx html directory
COPY --from=build-stage /app/dist/lazy-pro /usr/share/nginx/html
# Expose port 80 for the Nginx server
EXPOSE 80
# Run Nginx in the foreground (default command)
CMD ["nginx", "-g", "daemon off;"]
