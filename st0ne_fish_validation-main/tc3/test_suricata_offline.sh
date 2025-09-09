#!/bin/bash

# Color definitions
LIGHT_ORANGE='\033[0;93m'   # Intro messages
GREEN='\033[0;32m'          # Success messages
RED='\033[0;31m'            # Error messages
NC='\033[0m'                # No color / reset

# Introductory message
echo -e "${LIGHT_ORANGE}This is Test Case 3 – Processing a PCAP file in offline mode${NC}"

# Step 1: Identify the PCAP file in the current directory
pcap_file=$(find . -maxdepth 1 -iname "*.pcap" | head -n 1)

if [[ -z "$pcap_file" ]]; then
  echo -e "${RED}No PCAP file found in the current directory.${NC}"
  exit 1
fi

echo -e "${GREEN}Found PCAP file: $pcap_file${NC}"

# Step 2: Run Suricata in offline mode
mkdir -p ./logs
echo -e "${GREEN}Running Suricata on $pcap_file...${NC}"
suricata -r "$pcap_file" -l ./logs --runmode single -k none

# Step 3: Count the number of entries in eve.json and fast.log
eve_count=$(wc -l < ./logs/eve.json)
fast_count=$(wc -l < ./logs/fast.log)

echo -e "${GREEN}eve.json contains $eve_count entries.${NC}"
echo -e "${GREEN}fast.log contains $fast_count entries.${NC}"

# Step 4: Delete the log files
echo -e "${GREEN}Deleting log files...${NC}"
rm -f eve.json fast.log stats.log suricata.log

echo -e "${GREEN}Log files deleted.${NC}"
