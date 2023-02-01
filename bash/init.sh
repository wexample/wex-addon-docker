#!/bin/bash

_wexDockerFindImageDir() {
  local ADDONS_DIRS
  ADDONS_DIRS=$(_wexFindAddonsDirs)

  for DIR in ${ADDONS_DIRS[@]}; do
    local DIR_IMAGES=${DIR}images/

    if [ -d "${DIR_IMAGES}" ]; then
      local IMAGES=($(ls -1 "${DIR_IMAGES}"))

      for DIR_IMAGE in ${IMAGES}; do
        if [ "${DIR_IMAGE}" = "${1}" ];then
          echo "${DIR_IMAGES}${DIR_IMAGE}/"
        fi
      done
    fi
  done
}

_wexDockerImageBuild() {
  local DIR=${1}
  local NAME
  local DOCKERFILE=${DIR}Dockerfile

  NAME=$(basename "${DIR}")
  DEPENDS_FROM=$(wex default::config/getValue -f="${DOCKERFILE}" -k=FROM)
  DEPENDS_FROM_WEX=$(sed -e 's/wexample\/\([^:]\{0,\}\):.\{0,\}/\1/' <<< ${DEPENDS_FROM})

  # Build parent.
  if [ "${DEPENDS_FROM}" != "${DEPENDS_FROM_WEX}" ];then
    _wexLog "Depends from ${DEPENDS_FROM_WEX}"
    local PARENT_IMAGE_DIR
    PARENT_IMAGE_DIR=$(_wexDockerFindImageDir "${DEPENDS_FROM_WEX}")

    _wexDockerImageBuild "${PARENT_IMAGE_DIR}" "${3}" "${3}"
  fi;

  _wexLog "Building docker image ${NAME}"

  # Check if image has already been built.
  for i in ${WEX_BUILT_IMAGES[@]}; do
    if [ "$i" = "${NAME}" ]; then
      _wexLog "Image already exists"
      return
    fi
  done

  WEX_BUILT_IMAGES=${WEX_BUILT_IMAGES}" "${1}

  local BUILD_CACHE=''
  # If no cache is set.
  if [ "${2}" = "true" ]; then
    BUILD_CACHE='--no-cache'
  fi;

  # Use wex version as tag
  local TAG_BASE=wexample/${NAME}

  local BUILD_QUIET=''
  if [ "${QUIET}" = true ]; then
    BUILD_QUIET='-q'
  fi;

  # Set build context.
  cd "${WEX_DIR_ROOT}../"

  # Build
  docker build ${BUILD_QUIET} -t "${TAG_BASE}" -t "${TAG_BASE}":latest -f "${DOCKERFILE}" . ${BUILD_CACHE}
}