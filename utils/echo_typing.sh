#!/bin/bash

echo_typing() {
  for ((i = 0; i <= ${#1}; i++)); do
    printf '%s' "${1:$i:1}"
    sleep 0.1
  done
  echo ""
}

export -f echo_typing
