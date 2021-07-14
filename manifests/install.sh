sh kubeflow.sh
kubectl apply -f cert-manager.yaml
kubectl apply -f cert-issuer.yaml
kubectl apply -f kubeflow_ingress.yaml