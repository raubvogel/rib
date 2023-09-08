#!/bin/sh
set -e

groupadd -g $EXTGID extgroup
usermod -G extgroup -a $DEVUSER 

su - $DEVUSER

# And we are done here
exec "$@"
