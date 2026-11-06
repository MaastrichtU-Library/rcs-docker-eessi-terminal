#!/bin/bash
# OpenShift assigns a random UID that has no entry in /etc/passwd or /etc/group.
# Add one so whoami, groups and anything resolving $USER behave normally.
if ! whoami >/dev/null 2>&1 && [ -w /etc/passwd ]; then
  echo "eessi:x:$(id -u):0:EESSI user:${HOME:-/home/persistent}:/bin/bash" >> /etc/passwd
fi
if ! getent group "$(id -g)" >/dev/null 2>&1 && [ -w /etc/group ]; then
  echo "eessi:x:$(id -g):" >> /etc/group
fi

exec "$@"
