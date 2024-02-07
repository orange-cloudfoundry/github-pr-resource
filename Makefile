
all: test check in out
	@# for bin in check in out; do go build -o "build/${bin}" -ldflags="-s -w" -v "cmd/${bin}/main.go"; done

generate: github.go git.go
	go generate ./...

.PHONY: test
test: generate
	gofmt -s -l -w .
	go vet -v ./...
	go test -race -v ./...

.PHONY: e2e
e2e: test
	go test -race -v ./... -tags=e2e

check: cmd/check/main.go
	go build -o "build/check" -ldflags="-s -w" -v "cmd/check/main.go"

in: cmd/in/main.go
	go build -o "build/in" -ldflags="-s -w" -v "cmd/in/main.go"

out: cmd/out/main.go
	go build -o "build/out" -ldflags="-s -w" -v "cmd/out/main.go"
