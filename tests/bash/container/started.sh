#!/usr/bin/env bash

containerStartedTest() {
  local CONTAINER_RUNS=true

  if [[ $(wex-exec container/started -n=wex_test) = false ]]; then
    CONTAINER_RUNS=false
  fi

  _wexTestAssertEqual "${CONTAINER_RUNS}" "false"
}
