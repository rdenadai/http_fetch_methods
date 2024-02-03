#!/bin/bash

cd /code

if [ "$MODE" = "development" ]; then
    if [ "$TYPE" = "sse" ]; then
        pip install debugpy -t /tmp && python /tmp/debugpy --wait-for-client --listen 0.0.0.0:5678 -m uvicorn http_fetch_methods.sse:app --host 0.0.0.0 --port 8080 --reload
    elif [ "$TYPE" = "wss" ]; then
        pip install debugpy -t /tmp && python /tmp/debugpy --wait-for-client --listen 0.0.0.0:5678 -m uvicorn http_fetch_methods.wss:app --host 0.0.0.0 --port 8080 --reload 
    fi
elif [ "$MODE" = "production" ]; then
    if [ "$TYPE" = "sse" ]; then
        gunicorn http_fetch_methods.sse:app -b 0.0.0.0:8080 -w 4 -k uvicorn.workers.UvicornWorker -t 300 --access-logfile - --error-logfile -
    elif [ "$TYPE" = "wss" ]; then
        gunicorn http_fetch_methods.wss:app -b 0.0.0.0:8080 -w 4 -k uvicorn.workers.UvicornWorker -t 300 --access-logfile - --error-logfile -
    fi
    
fi
