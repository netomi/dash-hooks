#!/bin/bash

poetry export --without-hashes --format=requirements.txt > /tmp/requirements.txt
cyclonedx-py requirements --format=json /tmp/requirements.txt > /tmp/cyclonedx.json
jq -r '.components[] | ("pypi/pypi/-/" + .name + "/" + .version)' /tmp/cyclonedx.json > /tmp/DEPENDENCIES
java -jar /opt/dash.jar -project technology.csi /tmp/DEPENDENCIES -summary DEPENDENCIES
