# Extract IP address from Docker container:
docker inspect stupefied_swartz | grep IPAddress | cut -d ":" -f2 | cut -d "\"" -f2