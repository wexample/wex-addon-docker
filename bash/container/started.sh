#!/usr/bin/env bash

containerStartedArgs() {
  _ARGUMENTS=(
    'names n "Names of containers separated by a comma. Return true only if one container is started." true'
    'all a "All containers runs" false'
  )
}

containerStarted() {
  local RUNNING=$(docker ps -q)
  local NAMES=$(wex string/split -t="${NAMES}")

  # Allow several names.
  for NAME in ${NAMES[@]}
  do
    local RUNS=false

    # Inspect not stopped containers
    for CONTAINER_ID in ${RUNNING[@]}
    do
      local CONTAINER_NAME=$(wex docker::container/name -i="${CONTAINER_ID}")
      # Searched is running.
      if [ "${CONTAINER_NAME}" = "${NAME}" ];then
        RUNS=true

        # Only one is enough.
        if [ "${ALL}" != true ];then
          echo true
          return
        fi
      fi
    done;
  done;

  # All containers should runs,
  # any has been detected as not running.
  if [ "${ALL}" = true ];then
    echo true
    return
  fi

  # One container must run,
  # any has been detected as running.
  echo false
}
