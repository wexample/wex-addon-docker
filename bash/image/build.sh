#!/usr/bin/env bash

imageBuildArgs() {
  _ARGUMENTS=(
    'image_name n "Image to build, should exists in a addon service" true'
    'flush_cache f "Remove existing images before rebuild" false'
    'flush_parent_caches ff "Ignore caches recursively" false'
  )
}

imageBuild() {
  local IMAGE_DIR
  IMAGE_DIR=$(_wexDockerFindImageDir "${IMAGE_NAME}")

  if [ "${IMAGE_DIR}" != "" ];then
    _wexMessage "Found image ${IMAGE_NAME}" "Directory ${IMAGE_DIR}"
    _wexDockerImageBuild "${IMAGE_DIR}" "${FLUSH_CACHE}" "${FLUSH_PARENT_CACHES}"
  fi
}
