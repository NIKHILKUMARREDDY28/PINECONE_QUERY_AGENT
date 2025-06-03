#!/bin/sh

#echo "===== Grabbing latest code ====="
#git checkout dev-01
#git pull origin dev-01


echo "===== stop current container ====="
docker stop pinecone-query-agent || true && docker rm pinecone-query-agent || true

echo "\n\n === Building Docker Image ==="
docker build -t pinecone-query-agent:latest .

echo "\n\n ===== Run docker for ai-core-services ==== "
docker run  --net=host \
  -e AI_ENV=dev\
  -e PORT=8000 \
  -e PYTHONUNBUFFERED=0 \
  -d \
  -p 8000:8000\
  --name pinecone-query-agent \
  pinecone-query-agent

echo "\n\n === Sleeping for 5 sec(s) ==="
sleep 5

echo "\n == Current docker instances ==="
docker ps -a

echo "\n == Log file ==="
docker logs --tail 30 pinecone-query-agent
