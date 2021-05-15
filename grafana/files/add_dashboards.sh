#!/bin/bash
set -e

NC='\033[0m'

RED='\033[00;31m'
GREEN='\033[00;32m'
YELLOW='\033[00;33m'
BLUE='\033[00;34m'
PURPLE='\033[00;35m'
CYAN='\033[00;36m'
LIGHTGRAY='\033[00;37m'
MAGENTA='\033[00;35m'
LRED='\033[01;31m'
LGREEN='\033[01;32m'
LYELLOW='\033[01;33m'
LBLUE='\033[01;34m'
LPURPLE='\033[01;35m'
LCYAN='\033[01;36m'
WHITE='\033[01;37m'

GRAFANA_URL=http://${GF_SECURITY_ADMIN_USER}:${GF_SECURITY_ADMIN_PASSWORD}@localhost:3000

grafana_api() {
  local verb=$1
  local url=$2
  local params=$3
  local bodyfile=$4
  local response
  local cmd

  cmd="curl -L -s --fail -H \"Accept: application/json\" -H \"Content-Type: application/json\" -X ${verb} -k ${GRAFANA_URL}${url}"
  [[ -n "${params}" ]] && cmd="${cmd} -d \"${params}\""
  [[ -n "${bodyfile}" ]] && cmd="${cmd} --data @${bodyfile}"
  echo -e "Running ${cmd}"
  eval ${cmd} || return 1
  return 0
}

replace_datasource() {
   local dashboard_file=$1
   local datasource_name=$2
   local old_datasource_name=$3
   cmd="sed -i.bak_remove \"s/${old_datasource_name}/${datasource_name}/g\" ${dashboard_file}"
   eval ${cmd} || return 1
   return 0
}

install_dashboards() {
  local dashboard

  for dashboard in /var/lib/grafana/ds/files/dashboards/*.json

  do
      if grafana_api POST /api/dashboards/db "" "${dashboard}"; then
	      echo -e "\n** ${GREEN}installed ok **${NC}"
      else
	      echo -e "\n** ${RED}installation of: ${PURPLE}\"${dashboard}\"${RED} failed.**${NC}"
      fi
  done
}

configure_grafana() {
  install_dashboards
}

configure_grafana

