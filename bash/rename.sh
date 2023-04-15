#!/bin/bash

# specify the source and destination directories
source=$1
prefix="/tmp/complete"
strippedsource=${source//$prefix/}
destination="/downloads"$strippedsource

mkdir -p "$destination/"
cp -r "$source"/* "$destination/"
rm -rf "$source"/*