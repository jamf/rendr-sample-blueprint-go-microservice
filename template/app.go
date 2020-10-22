package main

import (
	"fmt"
	"net/http"
)

func appInit() {
	http.HandleFunc("/", MainHandler)
}

func MainHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintln(w, "Hello world! Welcome to {{ name }}!")
}