docker build -t pedrokohler/multi-client:latest -t pedrokohler/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pedrokohler/multi-server:latest -t pedrokohler/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pedrokohler/multi-worker:latest -t pedrokohler/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push pedrokohler/multi-client:latest
docker push pedrokohler/multi-server:latest
docker push pedrokohler/multi-worker:latest
docker push pedrokohler/multi-client:$SHA
docker push pedrokohler/multi-server:$SHA
docker push pedrokohler/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=pedrokohler/multi-client:$SHA
kubectl set image deployments/server-deployment server=pedrokohler/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=pedrokohler/multi-worker:$SHA