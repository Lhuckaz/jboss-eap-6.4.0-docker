# jboss-eap-6.4.0-ssh-docker

    git clone https://github.com/Lhuckaz/jboss-eap-6.4.0-ssh-docker.git
    cd jboss-eap-6.4.0-ssh-docker
    
Baixar o zip ``jboss-eap-6.4.0.zip`` do site da Red Hat na mesma pasta


    docker build -t "jboss:6.4" .
    docker run -it -p 8080:8080 -p 9990:9990 -p 2222:22 --name jboss_6 jboss:6.4

Pegar a senha do root:

    docker exec -it jboss_6 cat /pass_root
    
Acessar o container vai ssh

    ssh -p 2222 root@<host>

É possivel trocar a senha do root:

    passwd root


Acessar: http://\<host\>:8080/

Acessar para Console Administrativo: http://\<host\>:9990/ <br />
Usuario: jboss <br />
Senha: jb0ss@dmin
