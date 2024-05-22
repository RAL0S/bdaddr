#!/usr/bin/env bash

set -e

show_usage() {
  echo "Usage: $(basename $0) takes exactly 1 argument (install | uninstall)"
}

if [ $# -ne 1 ]
then
  show_usage
  exit 1
fi

check_env() {
  if [[ -z "${RALPM_TMP_DIR}" ]]; then
    echo "RALPM_TMP_DIR is not set"
    exit 1
  
  elif [[ -z "${RALPM_PKG_INSTALL_DIR}" ]]; then
    echo "RALPM_PKG_INSTALL_DIR is not set"
    exit 1
  
  elif [[ -z "${RALPM_PKG_BIN_DIR}" ]]; then
    echo "RALPM_PKG_BIN_DIR is not set"
    exit 1
  fi
}

install() {
  wget https://github.com/RAL0S/bdaddr/releases/download/v5.64/bdaddr -O $RALPM_TMP_DIR/bdaddr
  mv $RALPM_TMP_DIR/bdaddr $RALPM_PKG_INSTALL_DIR/bdaddr
  chmod +x $RALPM_PKG_INSTALL_DIR/bdaddr
  ln -s $RALPM_PKG_INSTALL_DIR/bdaddr $RALPM_PKG_BIN_DIR/bdaddr
}

uninstall() {
  rm $RALPM_PKG_INSTALL_DIR/bdaddr
  rm $RALPM_PKG_BIN_DIR/bdaddr
}

run() {
  if [[ "$1" == "install" ]]; then 
    install
  elif [[ "$1" == "uninstall" ]]; then 
    uninstall
  else
    show_usage
  fi
}

check_env
run $1