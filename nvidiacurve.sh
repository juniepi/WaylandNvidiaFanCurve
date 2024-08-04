#!/bin/bash

# Function to set fan speed based on temperature
set_fan_speed() {
    local temperature=$1

    if ((temperature >= 0 && temperature <= 35)); then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=47" -a "[fan-1]/GPUTargetFanSpeed=47"
    elif ((temperature >= 36 && temperature <= 50)); then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=50" -a "[fan-1]/GPUTargetFanSpeed=50"
    elif ((temperature >= 51 && temperature <= 63)); then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=65" -a "[fan-1]/GPUTargetFanSpeed=65"
    elif ((temperature >= 64 && temperature <= 70)); then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=85" -a "[fan-1]/GPUTargetFanSpeed=85"
    elif ((temperature >= 71 && temperature <= 100)); then
        sudo -E nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan-0]/GPUTargetFanSpeed=100" -a "[fan-1]/GPUTargetFanSpeed=100"
    fi
}

# Main loop to monitor temperature every 30 seconds
while true; do
    temperature=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader)
    echo "Current GPU Temperature: $temperature°C"
    set_fan_speed $temperature
    sleep 30
done
