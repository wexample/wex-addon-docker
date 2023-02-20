#!/usr/bin/env bash

containerRunsTest() {
  local CONTAINER_RUNS=true

  if [[ $(wex-exec container/runs -c=wex_test) = false ]];then
    CONTAINER_RUNS=false
  fi

  _wexTestAssertEqual "${CONTAINER_RUNS}" "false"
}

