FROM cirrusci/flutter:stable

RUN mkdir /app
WORKDIR /app
COPY . .

RUN flutter doctor -v

RUN flutter config --enable-web

RUN flutter build web --release --web-renderer=auto