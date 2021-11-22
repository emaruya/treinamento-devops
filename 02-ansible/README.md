 ansible-playbook -i hosts inicio.yml -u ubuntu --private-key "~/.ssh/id_rsa"

 ssh -i /home/ubuntu/.ssh/id_rsa ubuntu@ec2-54-232-167-40.sa-east-1.compute.amazonaws.com

 ansible-playbook rds_prod.yml  --syntax-check # confere a sintax do arquivo yml