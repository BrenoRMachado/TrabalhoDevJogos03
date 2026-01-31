#!/bin/sh
printf '\033c\033]0;%s\a' Trabalho3
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Trabalho3.x86_64" "$@"
