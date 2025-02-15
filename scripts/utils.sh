#!/bin/bash
set -euo pipefail

function help() {
    echo "SHOW HELP..."
    exit 0
}

DISK_PATH=${INSTANCE_DISK_PATH:-"/dev/nvme1n1"}

# Compose local properties with flag options
while [ "$#" -ne 0 ] ; do
    case "$1" in
        utils)
            shift
            ;;
        fs-status)
            clear
            echo ""
            echo " ---- DISK INFO ----"
            sudo file -s $DISK_PATH
            echo ""
            echo "If DISK INFO show (data) execute this command:"
            echo "----->   sudo mkfs -t xfs ${DISK_PATH}"
            echo ""
            echo ""
            shift
            ;;
        fs-info)
            clear
            echo ""
            echo "/////// FILESYSTEM DISK INFO //////"
            echo ""
            df -H
            echo ""
            echo "///// Check attached EBS volumes /////"
            echo ""
            lsblk
            echo ""
            echo "///// -------------------------- /////"
            shift
            ;;
        fs-mount)
            echo ""
            [ -d /docker-data ] || sudo mkdir /docker-data
            sudo mount $DISK_PATH /docker-data
            humble utils fs-info
            shift
            ;;
        fs-unmount)
            echo "You are about to UNMOUNT all data disks"
            echo "are you sure?"
            enterToContinue
            sudo umount /docker-data
            sudo rm -rf /docker-data
            humble utils fs-info
            shift
            ;;
        *)
            help
            shift
            ;;
    esac
done
