#! /bin/bash

# Assuming in your root repository, there are folders that are named
# after environments (prod, dev, qa, stg), this bash script will output
# the environment.

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IFS='/' read -r -a DIR_ARRAY <<< "$DIR"
GIT_REPO=some-repo

for ((i=0; i < ${#DIR_ARRAY[@]}; i++)) do
    if [ "${DIR_ARRAY[$i]}" = "$GIT_REPO" ] ; then
        echo ${DIR_ARRAY[$i+1]}
    fi
done
