#!/bin/bash

# Color variables
LIGHT_ORANGE='\033[38;5;208m'
GREEN='\e[32m'
RED='\e[31m'
NC='\e[0m'  # Reset formatting

# Intro message
echo -e "${LIGHT_ORANGE}This is test case 1 - checking for minimum software.${NC}"

programs=("pipx" "suricata" "zeek" "wireshark")
all_ok=true

# Check command-line tools
for prog in "${programs[@]}"; do
  if command -v "$prog" >/dev/null 2>&1; then
    echo -e "  ${GREEN}$prog is installed.${NC}"
  else
    echo -e "  ${RED}$prog is NOT installed.${NC}"
    all_ok=false
  fi
done

# Check for NetworkMiner executable
if ls /opt/NetworkMiner_*/NetworkMiner.exe >/dev/null 2>&1; then
  echo -e "  ${GREEN}NetworkMiner executable found.${NC}"
else
  echo -e "  ${RED}NetworkMiner executable NOT found.${NC}"
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
