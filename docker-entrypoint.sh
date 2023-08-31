#!/bin/sh
set -e

groupadd -g $EXTGID extgroup
usermod -G extgroup,mock -a $DEVUSER 

su - $DEVUSER

# And we are done here
exec "$@"
