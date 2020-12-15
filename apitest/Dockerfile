FROM golang:1.14 AS build

RUN mkdir /src
COPY go.mod /src
COPY main.go /src

WORKDIR /src
RUN go get 
RUN go build

FROM ubuntu AS final


RUN mkdir /app
COPY --from=build /src/apitest /usr/local/bin/apitest
COPY entrypoint.sh /entrypoint.sh


EXPOSE 10000/tcp
USER 45643:45643
ENTRYPOINT ["/entrypoint.sh"]


