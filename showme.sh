function showme() {
    echo "OS: "
    uname -a
    echo -e "\nUptime: "
    uptime 
    echo -e "\nMemory: "
    free #for mac, use top -l 1 -s 0 | grep PhysMem
    echo -e "\nWAN IP :"
    curl -s icanhazip.com
}