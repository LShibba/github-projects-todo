
#!/bin/bash
set -e

# Receive the Python test results
TEST_RESULT="$1"

# Record the current time
TIMESTAMP=$(date -u +"%Y-%m-%d %H:%M:%S UTC")

# Location of index.html
INDEX_FILE="${GITHUB_WORKSPACE:-/app}/index.html"

# Replace the results section
python3 - "$INDEX_FILE" "$TEST_RESULT" "$TIMESTAMP" <<'PYTHON'
import sys
import html
from pathlib import Path

file_path = Path(sys.argv[1])
test_result = html.escape(sys.argv[2])
timestamp = html.escape(sys.argv[3])

content = file_path.read_text(encoding="utf-8")

start_marker = '<div id="test-results">'
end_marker = '</div>'

start = content.find(start_marker)

if start == -1:
    raise SystemExit("Error: test-results section not found")

end = content.find(end_marker, start)

if end == -1:
    raise SystemExit("Error: closing div not found")

replacement = (
    '<div id="test-results">\n'
    f'    <pre>{test_result}</pre>\n'
    f'    <p>Last updated: {timestamp}</p>\n'
    '</div>'
)

content = (
    content[:start]
    + replacement
    + content[end + len(end_marker):]
)

file_path.write_text(content, encoding="utf-8")
PYTHON

echo "index.html updated successfully!"
