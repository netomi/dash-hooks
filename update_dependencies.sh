#!/bin/bash

while getopts ":m:" opt; do
  case "$opt" in
    m) MODULES="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    exit 1
    ;;
  esac

  case $OPTARG in
    -*) echo "Option $opt needs a valid argument"
    exit 1
    ;;
  esac
done

if [ -n "${MODULES-}" ]; then
  MODULE_FLAG="--with=${MODULES}"
fi

poetry export "${MODULE_FLAG:-}" --without-hashes --format=requirements.txt > /tmp/requirements.txt
cyclonedx-py requirements --output-format=json /tmp/requirements.txt > /tmp/cyclonedx.json
jq -r '.components[] | ("pypi/pypi/-/" + .name + "/" + .version)' /tmp/cyclonedx.json > DEPENDENCIES
