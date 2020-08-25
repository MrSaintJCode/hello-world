#!/bin/bash

container=$1
image=$2

echo "[+] Checking Running Containers..."

container_name=$(docker ps -aqf "name=$container")
if [[ "$container_name" == "" ]]; then
        echo "[*] Docker Container Doesn't Currently Exist"
else
        echo "[*] Docker Image Exist"
        echo "[+] Attempting to Remove Image"
        docker stop $container_name
        docker rm $container_name
        container_name=$(docker ps -aqf "name=devops-container")
        if [[ "$container_name" == "" ]]; then
                echo "[*] Docker Container Removed"
        else
                echo "[X] Error Removing Docker Container"
                exit 1
        fi
fi

sleep 2

echo "[+] Checking for Duplicate Images..."

image_name=$(docker images -q $image)
if [[ "$image_name" == "" ]]; then
        echo "[*] Docker Image Doesn't Currently Exist"
else
        echo "[*] Docker Image Exist"
        echo "[+] Attempting to Remove Image"
        docker rmi $image_name
        image_name=$(docker images -q $image)
        if [[ "$image_name" == "" ]]; then
                echo "[*] Docker Image Removed"
        else
                echo "[X] Error Removing Docker Image"
                exit 1
        fi
fi
