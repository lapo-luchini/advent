package main
import (
    "bufio"
    "fmt"
    "os"
    "strings"
)
func search(message string) int {
    var match = ""
    for i, letter := range message {
        idx := strings.IndexRune(match, letter)
        if (idx >= 0) {
            // drop everything up until equal char
            match = match[idx+1:]
        }
        match = match + string(letter)
        fmt.Println(i, match)
        if (len(match) == 4) {
            return i + 1
        }
    }
    return -1
}
func main() {
    scanner := bufio.NewScanner(os.Stdin)
    for scanner.Scan() {
        ln := scanner.Text()
        fmt.Println(ln, "=", search(ln))
    }
}
