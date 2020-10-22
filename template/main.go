package main

import (
	"net/http"
	"fmt"
)

func main() {
	healthInit()
    appInit()
    fmt.Println("Serving {{ name }} at http://localhost:{{ port }}! Use Ctrl-C to exit.")
    fmt.Println("Available endpoints:")
    fmt.Println(" * http://localhost:{{ port }}         - Welcome page")
    fmt.Println(" * http://localhost:{{ port }}/health  - Health metrics")
    http.ListenAndServe(":{{ port }}", nil)
}
