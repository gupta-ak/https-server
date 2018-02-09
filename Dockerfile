FROM golang:1.9.4-windowsservercore-1709 AS build
COPY . ./
RUN go build -o http.exe main.go
RUN go build -o gen-cert.exe generate_cert.go
RUN ["gen-cert.exe", "--host=127.0.0.1"]

FROM microsoft/nanoserver:1709
COPY --from=build C:/gopath/http.exe C:/gopath/cert.pem C:/gopath/key.pem /
ENTRYPOINT ["http.exe"]