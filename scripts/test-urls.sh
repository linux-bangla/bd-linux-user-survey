#!/bin/bash

CF_DOMAIN="tuxstats.com"

URLS=(
	"https://$CF_DOMAIN/"
	"https://$CF_DOMAIN/form"
	"https://$CF_DOMAIN/data"
	"https://$CF_DOMAIN/result"
	"https://$CF_DOMAIN/2025/form"
	"https://$CF_DOMAIN/2025/data"
	"https://$CF_DOMAIN/2025/result"
)

for url in "${URLS[@]}"; do
	echo "--- $url"
	curl -o /dev/null -s -w "HTTP %{http_code}\n" "$url"
done

# Uncomment to open each URL in Brave incognito one by one
# for url in "${URLS[@]}"; do
# 	echo "Opening: $url"
# 	brave-browser-stable --incognito "$url" &>/dev/null
# 	read -rp "Press Enter for next..."
# done
