#!/bin/bash

# Define script directories
SEARCH_DIR="search"
OUTPUT_DIR="output"
INTERACTIVE_DIR="interactive"
BATCH_DIR="batch"
CONFIG_DIR="config"

# Define script paths
FILE_SEARCH_SCRIPT="$SEARCH_DIR/file_search.sh"
FILE_FILTER_SCRIPT="$SEARCH_DIR/file_filter.sh"
OUTPUT_FORMATTER_SCRIPT="$OUTPUT_DIR/output_formatter.sh"
INTERACTIVE_MODE_SCRIPT="$INTERACTIVE_DIR/interactive_mode.sh"
BATCH_PROCESSING_SCRIPT="$BATCH_DIR/batch_processing.sh"
BATCH_CONFIG_FILE="$CONFIG_DIR/batch_config.txt"

# Define default values
DEFAULT_PATH="."
DEFAULT_FORMAT="long"
DEFAULT_SORT="name"

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -n|--name)
            NAME_PATTERN="$2"
            shift 2
            ;;
        -c|--content)
            CONTENT_PATTERN="$2"
            shift 2
            ;;
        -s|--size)
            SIZE_FILTER="$2"
            shift 2
            ;;
        -t|--type)
            TYPE_FILTER="$2"
            shift 2
            ;;
        -m|--modified)
            MODIFIED_FILTER="$2"
            shift 2
            ;;
        -o|--owner)
            OWNER_FILTER="$2"
            shift 2
            ;;
        -p|--permissions)
            PERMISSIONS_FILTER="$2"
            shift 2
            ;;
        -e|--exclude)
            EXCLUDE_PATTERN="$2"
            shift 2
            ;;
        -f|--format)
            OUTPUT_FORMAT="$2"
            shift 2
            ;;
        -S|--sort)
            SORT_CRITERIA="$2"
            shift 2
            ;;
        -i|--interactive)
            INTERACTIVE_MODE=true
            shift
            ;;
        -b|--batch)
            BATCH_MODE=true
            BATCH_CONFIG_FILE="$2"
            shift 2
            ;;
        --)
            shift
            break
            ;;
        -*)
            echo "Error: Invalid option $1" >&2
            exit 1
            ;;
        *)
            SEARCH_PATH="${1:-$DEFAULT_PATH}"
            shift
            ;;
    esac
done

# Perform search and filtering
INITIAL_RESULTS=$($FILE_SEARCH_SCRIPT "$SEARCH_PATH" "$NAME_PATTERN" "$CONTENT_PATTERN")
FILTERED_RESULTS=$($FILE_FILTER_SCRIPT "$INITIAL_RESULTS" "$SIZE_FILTER" "$TYPE_FILTER" "$MODIFIED_FILTER" "$OWNER_FILTER" "$PERMISSIONS_FILTER" "$EXCLUDE_PATTERN")

# Format and output results
OUTPUT_FORMAT="${OUTPUT_FORMAT:-$DEFAULT_FORMAT}"
SORT_CRITERIA="${SORT_CRITERIA:-$DEFAULT_SORT}"
$OUTPUT_FORMATTER_SCRIPT "$FILTERED_RESULTS" "$OUTPUT_FORMAT" "$SORT_CRITERIA"

# Handle interactive mode
if [[ "$INTERACTIVE_MODE" == true ]]; then
    echo "$FILTERED_RESULTS" | $INTERACTIVE_MODE_SCRIPT
fi

# Handle batch mode
if [[ "$BATCH_MODE" == true ]]; then
    $BATCH_PROCESSING_SCRIPT "$BATCH_CONFIG_FILE"
fi