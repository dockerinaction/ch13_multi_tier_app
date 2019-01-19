FROM golang as app
WORKDIR /go/src/app
COPY ./api/main.go .
RUN go get ./...
RUN CGO_ENABLED=0 go build

FROM golang:alpine as health
WORKDIR /go/src/app
COPY ./httpping/main.go .
RUN CGO_ENABLED=0 go build

FROM scratch
ENTRYPOINT ["/bin/service"]
HEALTHCHECK --interval=10s CMD ["/bin/httpping"]
COPY --from=app /go/src/app/app /bin/service
COPY --from=health /go/src/app/app /bin/httpping
