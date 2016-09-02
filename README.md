# jboss-eap-6.4.0-ssh-docker

    git clone https://github.com/Lhuckaz/jboss-eap-6.4.0-ssh-docker.git
    cd jboss-eap-6.4.0-ssh-docker
    
Baixar o zip ``jboss-eap-6.4.0.zip`` do site da Red Hat na mesma pasta


    docker build -t "jboss:6.4" .
    docker run -it -p 8080:8080 -p 9990:9990 --name jboss_6 jboss:6.4

    
Acessar: http://\<host\>:8080/

Para adicionar um usuario Administrador:

    docker exec -it jboss_6 ./jboss-eap-7.0/bin/add-user.sh

Acessar: http://\<host\>:9990/
