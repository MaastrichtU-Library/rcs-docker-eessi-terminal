#!/bin/bash
# OpenShift assigns a random UID that has no entry in /etc/passwd or /etc/group.
# Add one so whoami, groups and anything resolving $USER behave normally.
if ! whoami >/dev/null 2>&1 && [ -w /etc/passwd ]; then
  echo "eessi:x:$(id -u):0:EESSI user:${HOME:-/data/persistent}:/bin/bash" >> /etc/passwd
fi

# Name every group this UID is in that has no /etc/group entry.
if [ -w /etc/group ]; then
  for gid in $(id -G); do
    getent group "$gid" >/dev/null 2>&1 || echo "grp${gid}:x:${gid}:" >> /etc/group
  done
fi

exec "$@"
