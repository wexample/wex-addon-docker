#!/usr/bin/env bash

containerNameArgs() {
  _DESCRIPTION="Return full container name based on its id"
  _ARGUMENTS=(
    'id i "Id of container" true'
  )
}

containerName() {
  NAME=$(docker inspect --format="{{.Name}}" "${ID}")
  # Remove first char slash.
  echo "${NAME:1}"
}
