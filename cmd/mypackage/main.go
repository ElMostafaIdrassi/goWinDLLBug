package main

import "C"

//export Hello
func Hello() *C.char {
	return C.CString("hello")
}

func main() {}
