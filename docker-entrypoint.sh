#!/bin/sh
set -e

groupadd -g $EXTGID extgroup
usermod -G extgroup,mock -a $DEVUSER 
# usermod -G extgroup,mock -a root 

# su - $DEVUSER

# And we are done here
exec "$@"
