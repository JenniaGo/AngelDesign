!#/bin/bash
# add HashiCorp key
curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
# install apt-add-repo command
apt-get install software-properties-common
# add the official HashiCorp Linux repository
apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com
$(lsb_release -cs) main"
# update and install
apt-get update && apt-get install terraform
# verify
terraform -v
