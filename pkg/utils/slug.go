package utils

import (
	"regexp"
	"strings"
)

func slugify(s string) string {
	s = strings.ToLower(s)
	re := regexp.MustCompile("[^a-z0-9]+")
	s = re.ReplaceAllString(s, "")
	s = strings.Trim(s, " ")

	return s
}
