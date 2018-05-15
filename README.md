Vowpal Wabbit
-------------

Docker run
==========

This Docker image automatically sets the cache and model file to /app/saved-data.

To run it:

```bash
$VOLUME_LOCATION=/srv/saved-data # Set a volume to locally save/fetch the model and cache
$PORT=26542 #Set the port to access Vowpal Wabbit
$NAME=my-vowpal-wabbit
# Note: can be any option you want for Vowpal Wabbit. This is for reference only
$VOWPAL_WABBIT_OPTIONS="--loss_function poisson --max_prediction 6 --min_prediction -5"
mkdir -p $VOLUME_LOCATION

docker run -d --restart always -p $PORT:26542 --name $NAME \
    -v $VOLUME_LOCATION:/app/saved-data desaintmartin/vowpal-wabbit \
    $VOWPAL_WABBIT_OPTIONS
```
