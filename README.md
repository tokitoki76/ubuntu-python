# python-nginx-uwsgi

### purpose

Create docker container that has 

* nginx
* uwsgi
* python script w/ flask 

It consists of the following directories and files.

```
├── app/
│   ├── main.py
│   ├── uwsgi.ini
│   ├── requirements.txt
│
├── nginx.conf
├── start.sh
├── Dockerfile
└── docker-compose.yaml
```

### How to build

```
docker-compose build --no-cache
```

### Create & start the container

```
docker-compose up -d
```

### How to access through Flask

call api w/ curl.

```
curl http://localhost:5001/api 
```

response should be

```
{"message":"Hello, World!"}
```

