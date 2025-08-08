# Use the official Dart runtime as a parent image
FROM dart:stable AS build

# Set the working directory
WORKDIR /app

# Copy pubspec files
COPY pubspec.* ./

# Install dependencies
RUN dart pub get

# Copy the source code
COPY . .

# Compile the application
RUN dart compile exe lib/server.dart -o server

# Build minimal serving image from AOT-compiled `/server`
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/server /app/server
COPY --from=build /app/.env /app/.env

# Expose port
EXPOSE 8080

# Start the server
ENTRYPOINT ["/app/server"]
