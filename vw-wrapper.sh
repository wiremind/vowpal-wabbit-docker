#!/bin/sh

VW="vw"
SAVE_FILE="/app/saved-data/save.model"
CACHE_FILE="/app/saved-data/vw.cache"
PARAMS="--daemon --foreground -f $SAVE_FILE --cache_file $CACHE_FILE"

if [ -f $SAVE_FILE ]; then
  echo "Previous model found: loading it."
  COMMAND="$VW $PARAMS -i $SAVE_FILE $@"
  echo "Running $COMMAND"
  $COMMAND
else
  COMMAND="$VW $PARAMS $@"
  echo "Running $COMMAND"
  $COMMAND
fi

