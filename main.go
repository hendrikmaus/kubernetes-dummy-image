package main

import (
	"fmt"
	"log"
	"os"
	"os/signal"
	"syscall"
)

func main() {
	c := make(chan os.Signal, 1)
	signal.Notify(c, syscall.SIGINT, syscall.SIGTERM, syscall.SIGKILL)
	fmt.Println("Waiting for signals...")
	s := <-c
	fmt.Println("Got signal:", s)
	if s == syscall.SIGKILL {
		log.Fatal("SIGKILL")
	}
}
