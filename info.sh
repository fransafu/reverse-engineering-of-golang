# Check if argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <binary_file>"
    exit 1
fi

# Basic file info
echo "=== File Information ==="
file "$1"

# Go version information
echo -e "\n=== Go Version ==="
strings "$1" | grep "go1\."

# Header information for macOS
echo -e "\n=== Binary Headers ==="
otool -h "$1" || echo "Failed to read headers"

# Load commands
echo -e "\n=== Load Commands ==="
otool -l "$1" || echo "Failed to read load commands"

# Symbol table for macOS
echo -e "\n=== Symbol Table ==="
nm "$1" 2>/dev/null || echo "nm command failed - binary might be stripped"

# Extract readable strings
echo -e "\n=== Extracting Strings ==="
strings -n 8 "$1" > "./output/$1.strings"
echo "Strings saved to $1.strings"

# Get function names and symbols
echo -e "\n=== Go Functions ==="
go tool nm "$1" 2>/dev/null || echo "Failed to extract Go symbols"

# For stripped binaries, look for Go runtime functions
echo -e "\n=== Runtime Functions ==="
otool -tv "$1" 2>/dev/null | grep -A 20 "runtime.main" || echo "Failed to find runtime.main"
