Vowpal Wabbit
-------------

Docker run
==========

This Docker image automatically sets the cache and model file to /app/saved-data.

To run it:

```bash
VOLUME_LOCATION=/srv/saved-data # Set a volume to locally save/fetch the model and cache
VOWPAL_PORT=26542 # Set the port to access Vowpal Wabbit
HTTP_PORT=5000 # Set the port to access small web server allowing to dump model to s3
NAME=my-vowpal-wabbit
# Note: can be any option you want for Vowpal Wabbit. This is for reference only
VOWPAL_WABBIT_OPTIONS="--loss_function poisson --max_prediction 6 --min_prediction -5"
mkdir -p $VOLUME_LOCATION

docker run -d --restart always -p $VOWPAL_PORT:26542 -p $HTTP_PORT:5000 -p--name $NAME \
    -e S3_ENABLED=1 \
    -e S3_URL='minio.yourserver.net' -e S3_ACCESS_KEY=abcdefghi -e S3_SECRET_KEY=jklmnopqr
    -v $VOLUME_LOCATION:/app/saved-data desaintmartin/vowpal-wabbit \
    $VOWPAL_WABBIT_OPTIONS
```

When you are done, you can ask Vowpal Wabbit to dump the saved model to an S3 bucket by calling:

    http://localhost:$HTTP_PORT/triggerUpload

