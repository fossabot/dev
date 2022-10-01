#!/bin/sh

set -exfu

/tailscaled --statedir=/var/lib/tailscale &

container_ip=`ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | cut -d' ' -f1`

if [[ -n "${DEFN_DEV_TSKEY:-}" ]]; then
  mkdir -p /dev/net
  mknod /dev/net/tun c 10 200
  /tailscale up --authkey="${DEFN_DEV_TSKEY}" --accept-dns=false --ssh
fi

while true; do
  ts_ip=`/tailscale ip -4 || true`
  if test -n "${ts_ip}"; then break; fi
  sleep 1
done

domain=
while test -z "${domain}"; do
domain=`/tailscale cert 2>&1 | grep ' use ' | cut -d'"' -f2`
sleep 1
done

if [[ -z "${DEFN_DEV_TSKEY:-}" ]]; then
  /tailscale up --ssh --accept-dns=false --hostname `echo ${domain} | cut -d. -f1`
fi

if [[ -n "${DEFN_DEV_TSKEY:-}" ]]; then
  exec /bin/k3s-real "$@" --node-ip "${ts_ip}"
else
  exec /bin/k3s-real "$@" --node-ip "${ts_ip}" --node-external-ip "${ts_ip}"
fi
