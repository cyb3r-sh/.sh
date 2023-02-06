#!/bin/bash

source "../utils/show_cyb3r.sh"
source "../utils/echo_typing.sh"
source "../utils/only_root.sh"

networks=()

function fill_networks_array {
    network_links="$(ip -br l | awk {'print $1'})"
    IFS=$'\n' read -d '' -r -a items <<<"$network_links"

    for item in "${items[@]}"; do
        if [[ $item =~ "wlan" || $item =~ "eth" ]]; then
            networks+=("$item")
        fi
    done
}

function change_network_status_to {
    for network in "${networks[@]}"; do
        sudo ip link set $network $1
    done
}

function spoofing {
    for network in "${networks[@]}"; do
        echo "Spoofing $network..."
        sudo macchanger -a $network
        echo "==========================================="
    done
}

only_root
show_cyb3r

fill_networks_array

echo_typing "Stopping networks..."
echo ""
change_network_status_to 'down'

spoofing

echo ""
echo_typing "Starting networks..."
change_network_status_to 'up'
