#!/bin/bash

# Directory containing the .ipynb files
NOTEBOOK_DIR="./submission" # Set to your notebook directory

# Directory to store the results
RESULTS_DIR="./submission"

AUTOGRADER_FILE=$(find ./dist -type f -name '*autograder*.zip')

NOTEBOOKS=($(find ./submission -name "*.ipynb"))

for notebook in "${NOTEBOOKS[@]}"; do
    
    echo "Processing $notebook..."

    # Extract filename without extension
    base_name=$(basename "$notebook" .ipynb)

    # Run Otter on the notebook
    otter run -a "$AUTOGRADER_FILE" "$notebook"

    # Check if results.json was created
    if [ -f "results.json" ]; then
        # Copy and rename results.json to the submission folder
        cp results.json "$RESULTS_DIR/${base_name}_results.json"
    else
        echo "No results.json generated for $notebook"
    fi
done


for notebook in "$NOTEBOOK_DIR"/*.ipynb; do
    echo "Processing $notebook..."
done