#!/bin/sh
echo -ne '\033c\033]0;EATI\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/EATI.x86_64" "$@"
