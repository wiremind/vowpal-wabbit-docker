from flask import Flask
import logging
from minio import Minio
from minio.error import (ResponseError, BucketAlreadyOwnedByYou,
                         BucketAlreadyExists)
import os
import time

app = Flask(__name__)
app.logger.setLevel(logging.ERROR)
logging.getLogger('werkzeug').setLevel(logging.ERROR)

minioClient = None
bucket_name = os.environ.get('S3_BUCKET_NAME', 'vowpal')
model_name = os.environ.get('VOWPAL_WABBIT_MODEL_NAME')

@app.route('/triggerUpload')
def triggerUpload():
    try:
        minioClient.fput_object(bucket_name, 'model_%s_%s' % (model_name, time.strftime("%Y%m%d-%H%M%S")), '/app/saved-data/save.model')
    except ResponseError as err:
        print(err)
        return err, 500
    return 'Done.'

@app.route('/healthz')
def healthz():
    return '{"healthy": true}'

def main():
    global minioClient
    secure = not not os.environ.get('S3_SECURE', '')
    minioClient = Minio(os.environ['S3_URL'],
                        access_key=os.environ['S3_ACCESS_KEY'],
                        secret_key=os.environ['S3_SECRET_KEY'],
                        secure=secure)
    # Make a bucket with the make_bucket API call.
    try:
        minioClient.make_bucket(bucket_name, location="us-east-1")
    except BucketAlreadyOwnedByYou:
        pass
    except BucketAlreadyExists:
        pass
    except ResponseError:
        raise
    app.run(host='0.0.0.0')
