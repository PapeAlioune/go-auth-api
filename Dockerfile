# ./Dockerfile
FROM golang:1.17-alpine AS builder

# Move to working directory (/build).
WORKDIR /build

# Copy the code into the container.
COPY . .

# Download dependency using go mod.
RUN go mod download


# Set necessary environment variables needed for our image
ENV CGO_ENABLED=0 GOOS=linux GOARCH=amd64

# Build the API server.
RUN go build -mod=readonly -a -installsuffix cgo -o go-auth-api .

FROM scratch

# Copy binary and config files from /build 
# to root folder of scratch container.
COPY --from=builder ["/build/go-auth-api", "/build/.env", "/"]

# Export necessary port.
EXPOSE 5000

# Command to run when starting the container.
ENTRYPOINT ["/go-auth-api"]
