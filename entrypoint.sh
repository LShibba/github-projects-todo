
#!/bin/bash
set -e

echo "Starting Todo Application CI/CD Pipeline..."

# Set repository workspace
WORKSPACE="${GITHUB_WORKSPACE:-/app}"
cd "$WORKSPACE"

# Run automated Python tests and capture output
echo "Running Python tests..."

set +e
TEST_RESULT=$(python3 todo-test.py 2>&1)
TEST_STATUS=$?
set -e

# Display the results in the workflow logs
echo "$TEST_RESULT"

# Update index.html with the results
echo "Updating index.html..."
bash /app/update_index.sh "$TEST_RESULT"

# Report the final status
if [ "$TEST_STATUS" -eq 0 ]; then
    echo "All tests passed!"
    echo "CI/CD Pipeline Completed Successfully!"
else
    echo "Python tests failed!"
    exit "$TEST_STATUS"
fi
