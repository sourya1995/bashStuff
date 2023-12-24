package main

import (
	"fmt"
	"os"
	"os/signal"
	"syscall"
)

func main() {

	// Very simple argument parser.
	// Don't run this unless the user specifies "start"
	args := os.Args[1:]

	if len(args) == 0 {
		fmt.Println("Responder - Capture SIGHUP, SIGINT, SIGTERM, SIGQUIT")
		fmt.Println("Run with")
		fmt.Println("   responder start &")
		fmt.Println("Stop with kill -SIGKILL")
	} else if args[0] == "start" {

		// create a channel for signals
		signals := make(chan os.Signal, 1)

		// apparently even tho passing no signals is supposed to catch all, it
		// doesn't quite work, as SIGQUIT goes through.
		signal.Notify(signals, syscall.SIGHUP, syscall.SIGINT, syscall.SIGTERM, syscall.SIGQUIT)

		done := make(chan bool)

		go func() {
			// loop forever so the only way to stop is through a SIGKILL
			for {
				// hey we got a signal. Print it out. But DON'T call done so
				// the program keeps going.
				signal := <-signals
				fmt.Println(signal)
			}
		}()

		<-done
	}
}
