docker build -t aapurvk/multi-client:latest -t aapurvk/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aapurvk/multi-server:latest -t aapurvk/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t aapurvk/multi-worker:latest -t aapurvk/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push aapurvk/multi-client:latest
docker push aapurvk/multi-server:latest
docker push aapurvk/multi-worker:latest

docker push aapurvk/multi-client:$SHA
docker push aapurvk/multi-server:$SHA
docker push aapurvk/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=aapurvk/multi-server:$SHA
kubectl set image deployments/client-deployment client=aapurvk/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=aapurvk/multi-worker:$SHA
