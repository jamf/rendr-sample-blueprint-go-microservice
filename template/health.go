package main

import (
	"time"
	"net/http"

	"github.com/hellofresh/health-go/v3"
)

func healthInit() {
	health.Register(health.Config{
	  Name: "example health check",
	  Timeout: time.Second*5,
	  SkipOnErr: true,
	  Check: func() error {
		return nil
	  },
	})
  
	http.Handle("/health", health.Handler())
  }