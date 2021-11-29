package database

import (
	"github.com/PapeAlioune/go-auth-api/models"
	"gorm.io/driver/mysql"
	"gorm.io/gorm"
)

var (
	DB *gorm.DB
)

func Connect() {
	connection, err := gorm.Open(mysql.Open("root:goapisecret@tcp(localhost:3306)/go_rest?multiStatements=true"), &gorm.Config{})

	if err != nil {
		panic("could not connect to the database")
	}

	DB = connection

	connection.AutoMigrate(&models.User{})
}
