#!/bin/bash

function only_root {
  if [[ "$EUID" != 0 ]]; then
    echo "Error: Permission denied"
    exit 1
  fi
}

export -f only_root
