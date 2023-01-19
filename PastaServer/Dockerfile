FROM swift:latest

COPY . /app

WORKDIR /app

RUN swift build -c release --disable-sandbox

EXPOSE 8889

ENTRYPOINT ["/app/.build/release/PastaServer"]
