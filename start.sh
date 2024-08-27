#!/bin/bash

uwsgi --ini /app/uwsgi.ini &

nginx -g 'daemon off;'
