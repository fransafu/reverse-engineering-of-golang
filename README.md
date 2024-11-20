# Reverse engineering of simple Golang program

## Getting started

```bash
sh info.sh main > output/test.txt
```

## Dependencies

```bash
go install github.com/go-delve/delve/cmd/dlv@latest
go install golang.org/x/tools/cmd/godex@latest
```

## Generate binary

```bash
go build -o main main.go
```
