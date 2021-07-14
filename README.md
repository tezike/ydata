## PREREQUISITES
In order to ensure a successfull installation, please confirm you have `awscli`, `kubectl`, `kustomize`, `terraform` and `helm` installed on the machine you intend to run this script from.

## Installation
The easiest way to run this is by using the commands below from the root directory

```
cd terraform/
terraform init
terraform apply
```

Please type in `yes` when prompted and allow terraform do it's magic.

If you have all the prerequisites listed above installed, the full kubeflow installation with terraform should take approximately `25 mins`

**NB:** Terraform outputs a list of nameservers which point to `ydata.ml`. I manually copy this data and make the appropriate nameserver edits on my domain name registrar (I use freenom).


## KUBEFLOW WEBSITE
Visit `kubeflow.ydata.ml` 
login with
email: `user@example.com`
password: `12341234`