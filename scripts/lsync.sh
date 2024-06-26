#!/bin/bash
#

# Copyright DaoCloud authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http:/www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This script checks if the English version of a page has changed since a localized
# page has been committed.
# Instructions: in the repo directory, run `./scripts/lsync.sh docs/en/` to check
# differences between en and zh.

if [ "$#" -ne 1 ] ; then
  echo -e "\nThis script checks if the Chinese version of a page has changed since a " >&2
  echo -e "localized page has been committed.\n" >&2
  echo -e "Usage:\n\t$0 <PATH>\n" >&2
  echo -e "Example:\n\t$0 docs/en/docs/concepts/_index.md\n" >&2
  exit 1
fi

# Check if path exists, and whether it is a directory or a file
if [ ! -e "$1" ] ; then
  echo "Path not found: '$1'" >&2
  exit 2
fi

if [ -d "$1" ] ; then
  SYNCED=1
  for f in `find $1 -name "*.md"` ; do
    ZH_VERSION=`echo $f | sed "s/docs\/.\{2,5\}\//docs\/zh\//g"`
    if [ ! -e $ZH_VERSION ]; then
      echo -e "**removed**\t$ZH_VERSION"
      SYNCED=0
      continue
    fi

    LASTCOMMIT=`git log -n 1 --pretty=format:%h -- $f`
    git diff --exit-code --numstat $LASTCOMMIT...HEAD $ZH_VERSION
    if [ $? -ne 0 ] ; then
      SYNCED=0
    fi
  done
  if [ $SYNCED -eq 1 ]; then
    echo "$1 is still in sync"
    exit 0
  fi
  exit 1
fi

LOCALIZED="$1"

# Try get the Chinese version
ZH_VERSION=`echo $LOCALIZED | sed "s/docs\/.\{2,5\}\//docs\/zh\//g"`
if [ ! -e $ZH_VERSION ]; then
  echo "$ZH_VERSION has been removed."
  exit 3
fi

# Last commit for the localized path
LASTCOMMIT=`git log -n 1 --pretty=format:%h -- $LOCALIZED`

git diff --exit-code $LASTCOMMIT...HEAD $ZH_VERSION

if [ "$?" -eq 0 ]; then
  echo "$LOCALIZED is still in sync"
  exit 0
fi
