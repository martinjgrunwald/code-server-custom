#!/bin/bash

destination="/path/to/file"
reversed_destination=$(echo "$destination" | rev)
cut_destination="${reversed_destination#*/}"
destination=$(echo "$cut_destination" | rev)
echo "$destination"