#!/usr/bin/env bash
/etc/init.d/ssh start

set +e
exec "\$@"