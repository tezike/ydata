#!/bin/bash
## install twice
counter=2
while [ $counter -gt 0 ]
do
   kustomize build ydata_kubeflow | kubectl apply -f -
   # kustomize build ydata_kubeflow | kubectl delete -f -
     counter=$(( $counter - 1 ))
done