package main

import (
	"io"
	"log"
	"net/http"
)

func getIP(w http.ResponseWriter, r *http.Request) {
	ip := r.Header.Get("Cf-Connecting-Ip")

	_, err := io.WriteString(w, ip)
	if err != nil {
		log.Fatal(err)
	}

}

func main() {
	http.HandleFunc("/", getIP)
	log.Fatal(http.ListenAndServe(":10101", nil))
}
