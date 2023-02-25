#!/usr/bin/env bash

dockerStopAllArgs() {
  # shellcheck disable=SC2034
  _DESCRIPTION="Stops every running Docker container / network / volume"
}

dockerStopAll() {
  # Containers
  local CONTAINERS
  CONTAINERS=($(docker ps -qa))
  if ((${#CONTAINERS[@]} > 0)); then
    # Stop all
    docker stop "${CONTAINERS[@]}"
    # Remove
    docker rm "${CONTAINERS[@]}" -f
  fi

  # Networks
  # List all networks except builtin
  local NETWORKS
  NETWORKS=($(docker network ls -q --filter type=custom))
  if ((${#NETWORKS[@]} > 0)); then
    # Remove networks
    docker network rm "${NETWORKS[@]}"
  fi

  # Volumes
  local VOLUMES
  VOLUMES=$(docker volume ls -q)

  if ((${#VOLUMES[@]} > 1)); then
    docker volume rm "${VOLUMES[@]}"
  fi
}
