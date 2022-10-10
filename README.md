# Hedera-py-java

How to use this image:

## Docker-compose
Create a docker-compose.py file in your project root.
>Note: In this example I am using Flask as it requires very little set-up.

```
version: '3.7'
services:

  app:
    build:
      context: .
      dockerfile: Dockerfile
    platform: linux/amd64
    restart: unless-stopped
    volumes:
      - ./:/code
    ports:
      - 5000:5000
    env_file:
      - .env
    container_name: python_app
```
Create a .env file in your project root with the following variables:
```
export OPERATOR_ID=**get from https://portal.hedera.com**
export OPERATOR_KEY=**get from https://portal.hedera.com**
export HEDERA_ENV=**testnet, previewnet or mainnet**
```

Create a Dockerfile in you project root.
```
FROM bobbystearman/hedera-py-java

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

RUN mkdir /code
WORKDIR /code
COPY . .

RUN set -e; \
    pip install --upgrade pip \
    pip install Flask

ENTRYPOINT ["python","./server.py"]
```

Create a server.py file and use the following code:
```
from flask import Flask
server = Flask(__name__)

@server.route("/")
def hello():
   return "Hello future!"

if __name__ == "__main__":
   server.run(host='0.0.0.0')
```

***
***

## Fire up Docker:

>Note: You will need to make sure Docker is running on your machine!

Use the following command to build the docker images:
> Note: this command will create the Docker containers and configure everything you need to get started.
```
docker-compose up -d --build
```

### Access
You should now be up and running!

We are using Flask as we can run it without the need to configure components.
* The web app is running on  [http://localhost:5000](http://localhost:5000)

You can fire up a [Python](https://python.org) interpreter in your terminal with the following code.
```
docker exec -it python_app bash
python
```
Alternatively, You can open the cli using Docker desktop.
