#!/bin/sh
# Script for updating local list of tests. Please run this script timely,
# especially after adding new tests.

`find . -type f -iname '*.pkt' | cut -f 2 -d '.' > tests_list`
