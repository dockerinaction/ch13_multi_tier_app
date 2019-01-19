package main

import (
	"net/http"
	"os"
)

func main() {
	resp, err := http.Get("http://localhost:80/")
	if err != nil || resp == nil || resp.StatusCode != 200 {
		os.Exit(1)
	}
	os.Exit(0)
}
