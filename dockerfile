FROM golang:1.16-alpine as build

WORKDIR /go/src/app
COPY . .

RUN go mod init
RUN go get -d -v ./...
RUN go install -v ./...
RUN CGO_ENABLED=0 go build -ldflags="-s -w" -o ./build_app

FROM scratch
COPY --from=build /go/src/app/build_app /app

ENTRYPOINT ["/app"]