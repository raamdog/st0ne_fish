#!/bin/bash

# Define colors
LIGHT_ORANGE='\033[38;5;208m'
GREEN='\e[32m'
RED='\e[31m'
NC='\e[0m'  # No color reset

# Intro
echo -e "${LIGHT_ORANGE}This is test case 2 – verifying pipx and suricata-update${NC}"

all_ok=true

# Check pipx
if command -v pipx >/dev/null 2>&1; then
  echo -e "  ${GREEN}pipx is installed.${NC}"
else
  echo -e "  ${RED}pipx is NOT installed.${NC}"
  all_ok=false
fi

# Check suricata-update executing version flag
if command -v suricata-update >/dev/null 2>&1 && suricata-update -V >/dev/null 2>&1; then
  echo -e "  ${GREEN}suricata-update is installed and responsive.${NC}"
else
  echo -e "  ${RED}suricata-update not installed or not working.${NC}"
  all_ok=false
fi

echo -e "  ${LIGHT_ORANGE}Checking suricata-update. This might take a minute.${NC}"

# Optional: check version freshness
if pipx run suricata-update >/dev/null 2>&1; then
  echo -e "  ${GREEN}suricata-update executed successfully.${NC}"
else
  echo -e "  ${RED}suricata-update failed or flagged issues.${NC}"
  all_ok=false
fi

echo
if [ "$all_ok" = true ]; then
  echo -e "${GREEN}PASS${NC}"
  exit 0
else
  echo -e "${RED}FAIL${NC}"
  exit 1
fi
