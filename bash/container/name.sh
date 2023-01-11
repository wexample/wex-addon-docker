#!/usr/bin/env bash

containerNameArgs() {
  _ARGUMENTS=(
    'id i "Id of container" true'
  )
}

containerName() {
  NAME=$(docker inspect --format="{{.Name}}" "${ID}")
  # Remove first char slash.
  echo "${NAME:1}"
}
