# ImageProcessingServer

## Setup
### OSX
```sh
brew install postgresql
brew install redis
brew install imagemagick
```

```sh
pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start
```

### Setup S3
Create a config/s3.yml file (obtain credentials from AWS: https://aws.amazon.com/)
```yml
bucket: bucket
access_key_id: accesskey
secret_access_key: secretaccesskey
```

## Usage
```sh
bundle install
bundle exec rake db:setup
bundle exec foreman start
```

The easiest way to use this app is through the web interface:

`http://localhost:3000`

Background job monitoring:

`http://localhost:3000/sidekiq`

## API

1) Create a image processing request

  `POST /image_processing_requests.json`

  ```javascript
  {
    "image_processing_request": {
      "original_image_attributes": {
        "image": "data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw=="
      },
      "command_string": "-negate output.png",       // Arguments passed to the ImageMagick library "convert" command
                                                    // For example, "-negate output.png" inverts the image and saves it as a PNG file
      "callback_url": "http://example.com/callback" // Where to submit the processed image url when the processing job is complete
    }
  }
  ```

2) The response should look like this on success (a processing request job has been queued)

200 status code

```javascript
{
  "id": 1,
  "original_image_id": 1,
  "processed_image_id": 1,
  "processed": false,
  "command_string":"-negate output.png",
  "callback_url":"http://example.com/callback",
  "created_at": "2016-02-11T02:01:20.175Z",
  "updated_at":"2016-02-11T02:01:20.175Z"
}
```

3) If a callback url is specified, you will receive a POST request at the callback_url once the image has been processed.

```javascript
{
  "image_processing_request": {
    "id": 1,
    "processed_image_url": "http://example.com/output.png"
  }
}
```
