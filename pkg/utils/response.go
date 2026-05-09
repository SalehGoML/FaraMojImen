package utils

import "github.com/gin-gonic/gin"

type Response struct {
	Success bool        `json:"success"`
	Message string      `json:"message,omitempty"`
	Data    interface{} `json:"data,omitempty"`
	Error   string      `json:"error,omitempty"`
}

type PaginatedResponse struct {
	Success bool        `json:"success"`
	Data    interface{} `json:"data"`
	Total   int64       `json:"total"`
	Page    int         `json:"page"`
	Limit   int         `json:"limit"`
}

func OK(c *gin.Context, data interface{}) {
	c.JSON(200, Response{Success: true, Data: data})
}

func Created(c *gin.Context, data interface{}) {
	c.JSON(201, Response{Success: true, Data: data})
}

func BadRequest(c *gin.Context, msg string) {
	c.JSON(400, Response{Success: false, Error: msg})
}

func Unauthorized(c *gin.Context) {
	c.JSON(401, Response{Success: false, Error: "احراز هویت لازم است"})
}

func Forbidden(c *gin.Context) {
	c.JSON(403, Response{Success: false, Error: "دسترسی ندارید"})
}

func NotFound(c *gin.Context, msg string) {
	c.JSON(404, Response{Success: false, Error: msg})
}

func ServerError(c *gin.Context, err error) {
	c.JSON(500, Response{Success: false, Error: err.Error()})
}

func Paginated(c *gin.Context, data interface{}, total int64, page, limit int) {
	c.JSON(200, PaginatedResponse{
		Success: true,
		Data:    data,
		Total:   total,
		Page:    page,
		Limit:   limit,
	})
}
