#!/bin/bash

nmcli dev wifi list | awk '/\*/{if (NR!=1) {print $8}}'
