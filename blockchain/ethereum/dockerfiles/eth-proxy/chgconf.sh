#!/bin/bash
# Author: JinsYin <jinsyin@gmail.com>

EP_ENVS=$(env | grep "^EP_.*")

for proxy_env in ${EP_ENVS[@]}; do
  array=(${proxy_env//EP_/ })
  env_kv=(${array[0]//=/ })
  env_name=${env_kv[0]}
  env_value=${env_kv[1]}

  if [ -f /ethproxy/eth-proxy.conf ]; then
    if cat /ethproxy/eth-proxy.conf | grep "^$env_name = \""; then
      sed -i "s|^$env_name = .*$|$env_name = \"$env_value\"|" "$EP_CONF_PATH"
    else
      sed -i "s|^$env_name = .*$|$env_name = $env_value|" "$EP_CONF_PATH"
    fi
  fi
done

exec $@