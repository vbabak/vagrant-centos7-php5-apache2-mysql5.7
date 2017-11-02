#!/bin/sh

serviceCommand() {
  if systemctl list-unit-files | grep -Fq ${2}; then
    systemctl ${1} ${2}
  fi
}

serviceCommand restart httpd
serviceCommand restart mysqld

