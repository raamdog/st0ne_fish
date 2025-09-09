#!/bin/bash

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m'  # Reset

overall_pass=true
declare -A results

echo -e "${YELLOW}Running all test cases...${NC}"

# Loop through directories named tc*
for dir in tc*/; do
    if [[ -d "$dir" ]]; then
        # Find the first .sh file in the directory
        script=$(find "$dir" -maxdepth 1 -type f -name "*.sh" | head -n 1)

        if [[ -n "$script" ]]; then
            echo -e "\n${YELLOW}Running $script...${NC}"
            bash "$script"
            if [[ $? -eq 0 ]]; then
                echo -e "${GREEN}$script PASSED${NC}"
                results["$dir"]="PASS"
            else
                echo -e "${RED}$script FAILED${NC}"
                results["$dir"]="FAIL"
                overall_pass=false
            fi
        else
            echo -e "${RED}No .sh file found in $dir${NC}"
            results["$dir"]="MISSING"
            overall_pass=false
        fi
    fi
done

# Summary table
echo -e "\n${YELLOW}===== TEST SUMMARY =====${NC}"
for dir in "${!results[@]}"; do
    status="${results[$dir]}"
    if [[ "$status" == "PASS" ]]; then
        echo -e "$dir : ${GREEN}$status${NC}"
    elif [[ "$status" == "FAIL" ]]; then
        echo -e "$dir : ${RED}$status${NC}"
    else
        echo -e "$dir : ${YELLOW}$status${NC}"
    fi
done

echo
if $overall_pass; then
    echo -e "${GREEN}ALL TESTS PASSED ✅${NC}"
    exit 0
else
    echo -e "${RED}SOME TESTS FAILED ❌${NC}"
    exit 1
fi
