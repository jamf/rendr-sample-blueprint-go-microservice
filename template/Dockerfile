# This is a multistage Dockerfile, including build and runtime

# Build container
FROM golang:{{ golang_version }}-alpine AS build-env

RUN apk add --no-cache git
ADD . /src
RUN cd /src && go build -o {{ name }}

# Runtime container
FROM alpine

WORKDIR /app
COPY --from=build-env /src/{{ name }} /app/
EXPOSE {{ port }}

ENTRYPOINT ./{{ name }}
