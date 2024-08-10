FROM golang:1.22-alpine AS builder

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o fullcycle

######

FROM scratch 

COPY --from=builder /app/fullcycle /

ENTRYPOINT [ "/fullcycle" ]
