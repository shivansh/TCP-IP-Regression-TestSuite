#!/bin/sh
# Script for updating local list of tests. Please run this script timely.

`find . -type f -iname '*.pkt' | cut -f 2 -d '.' > tests_list`
