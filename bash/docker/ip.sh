#!/usr/bin/env bash

dockerIpArgs() {
  # shellcheck disable=SC2034
  _DESCRIPTION="Return the current docker local ip"
}

dockerIp() {
  # Docker IP is only localhost
  if [ "$(wex-exec system::system/os)" == "mac" ]; then
    echo "127.0.0.1"
    return
  fi

  if [ "$(command -v docker-machine)" ]; then
    echo $(docker-machine ip)
  else
    echo $(wex-exec system::system/ip)
  fi
}
