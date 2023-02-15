#!/usr/bin/env bash

containerRunsArgs() {
  _DESCRIPTION="Return true if docker container runs"
  _ARGUMENTS=(
    'container c "Container name" true'
    'all a "All, included stopped ones" false'
  )
}

containerRuns() {
  if [ "${ALL}" = true ];then
    ALL="-a"
  fi

  if docker ps ${ALL} | grep -q "${CONTAINER}"; then
    echo true
  else
    echo false
  fi;
}
