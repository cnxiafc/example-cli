.PHONY: build test lint release clean help

# Build variables
VERSION := $(shell git describe --tags --always --dirty 2>/dev/null || echo "dev")
COMMIT := $(shell git rev-parse --short HEAD 2>/dev/null || echo "unknown")
DATE := $(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
LDFLAGS := -s -w -X main.version=$(VERSION) -X main.commit=$(COMMIT) -X main.date=$(DATE)

# Default target
help:
	@echo "Available targets:"
	@echo "  build     - Build the binary for current platform"
	@echo "  build-all - Build binaries for all platforms"
	@echo "  test      - Run tests"
	@echo "  lint      - Run linters"
	@echo "  clean     - Clean build artifacts"
	@echo "  release   - Create a new release with goreleaser"
	@echo "  snapshot  - Create a snapshot release"
	@echo "  help      - Show this help message"

# Build for current platform
build:
	CGO_ENABLED=0 go build -ldflags="$(LDFLAGS)" -o bin/example-cli .

# Build for all platforms
build-all: clean
	@goreleaser build --snapshot --clean

# Run tests
test:
	go test -v ./...

# Run linters
lint:
	golangci-lint run ./...

# Clean build artifacts
clean:
	rm -rf bin/
	rm -rf dist/

# Create a new release
release:
	goreleaser release --clean

# Create a snapshot release
snapshot:
	goreleaser release --snapshot --clean