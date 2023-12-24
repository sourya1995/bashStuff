version = 0.2.0

mac:
	mkdir -p dist/mac
	env GOOS=darwin GOARCH=amd64 go build -o dist/mac/responder

linux:
	mkdir -p dist/linux
	env GOOS=linux GOARCH=amd64 go build -o dist/linux/responder

clean:
	rm -rf dist/
