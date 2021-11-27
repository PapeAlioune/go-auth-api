# ./Dockerfile

FROM golang:1.17-alpine AS builder

# Move to working directory (/build).
WORKDIR /build

# Copy and download dependency using go mod.
# COPY go.mod go.sum ./

# Copy the code into the container.
COPY . .
RUN go mod download


# Set necessary environment variables needed for our image 
# and build the API server.
ENV CGO_ENABLED=0 GOOS=linux GOARCH=amd64
RUN go build -mod=readonly -a -installsuffix cgo -o go-auth-api .

FROM scratch

# Copy binary and config files from /build 
# to root folder of scratch container.
COPY --from=builder ["/build/go-auth-api", "/build/.env", "/"]

# Export necessary port.
EXPOSE 5000

# Command to run when starting the container.
ENTRYPOINT ["/go-auth-api"]
