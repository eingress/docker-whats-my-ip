package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
)

func getIP(w http.ResponseWriter, r *http.Request) {
	ip := r.Header.Get("Cf-Connecting-Ip")
	if ip == "" {
		http.Error(w, "no Cf-Connecting-Ip header", http.StatusBadRequest)
		return
	}
	fmt.Fprintln(w, ip)
}

func health(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusOK)
}

func main() {
	port := os.Getenv("PORT")
	if port == "" {
		port = "10101"
	}
	http.HandleFunc("/", getIP)
	http.HandleFunc("/health", health)
	log.Fatal(http.ListenAndServe(":"+port, nil))
}
