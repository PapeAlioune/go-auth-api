package main

import (
	"github.com/PapeAlioune/go-auth-api/database"
	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/fiber/v2/middleware/cors"
)

func main() {
	database.InitDB()

	app := fiber.New()

	app.Use(cors.New(cors.Config{
		AllowCredentials: true,
	}))

	// routes.Setup(app)

	app.Listen(":8000")
}
