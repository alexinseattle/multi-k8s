docker build -t abelyaev/multi-client:latest -t abelyaev/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t abelyaev/multi-server:latest -t abelyaev/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t abelyaev/multi-worker:latest -t abelyaev/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push abelyaev/multi-client:latest
docker push abelyaev/multi-server:latest
docker push abelyaev/multi-worker:latest
docker push abelyaev/multi-client:$SHA
docker push abelyaev/multi-server:$SHA
docker push abelyaev/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=abelyaev/multi-server:$SHA
kubectl set image deployments/client-deployment client=abelyaev/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=abelyaev/multi-worker:$SHA

