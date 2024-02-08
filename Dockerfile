FROM ghcr.io/cirruslabs/flutter:3.16.6 as build

RUN mkdir /app
WORKDIR /app
COPY . .

RUN flutter doctor -v

RUN flutter config --enable-web

RUN flutter build web --release --web-renderer=auto

# Use Nginx to serve the Flutter web app
FROM nginx:latest

# Copy the custom Nginx configuration
COPY ./nginx.conf /etc/nginx/nginx.conf

# Copy the built Flutter web app to the Nginx server
COPY --from=build /app/build/web /usr/share/nginx/html

# Expose port 80 for the Nginx server
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]