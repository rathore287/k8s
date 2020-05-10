docker build -t rathore287/multi-client:latest -t rathore287/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rathore287/multi-server:latest -t rathore287/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rathore287/multi-worker:latest -t rathore287/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rathore287/multi-client:latest
docker push rathore287/multi-server:latest
docker push rathore287/multi-worker:latest

docker push rathore287/multi-client:$SHA
docker push rathore287/multi-server:$SHA
docker push rathore287/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rathore287/multi-server:$SHA
kubectl set image deployments/client-deployment client=rathore287/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rathore287/multi-worker:$SHA