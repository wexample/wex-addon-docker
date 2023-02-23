#!/usr/bin/env bash

containerNameArgs() {
  # shellcheck disable=SC2034
  _DESCRIPTION="Return full container name based on its id"
  # shellcheck disable=SC2034
  _ARGUMENTS=(
    'id i "Id of container" true'
  )
}

containerName() {
  NAME=$(docker inspect --format="{{.Name}}" "${ID}")
  # Remove first char slash.
  echo "${NAME:1}"
}
