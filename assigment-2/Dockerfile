FROM golang:1.16-alpine

WORKDIR /app

ENV BIND_ADDRESS=8080

COPY go.mod ./
RUN go mod download

COPY *.go ./

RUN go build -o app

CMD [ "sh","-c", "BIND_ADDRESS=:$BIND_ADDRESS ./app" ]
