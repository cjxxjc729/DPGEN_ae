#!/bin/bash

grep F= */*/OSZ* | awk -F ' ' '{print $8}' | sed "s/-\.//" | sort > sorted_energy

grep F= */*/OSZ* | awk -F ' ' '{print $8}' > energy_collection
