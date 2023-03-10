FROM ubuntu:latest

RUN apt-get update && apt-get install -y openssh-client
COPY id_rsa /root/.ssh/
COPY id_rsa.pub /root/.ssh/
RUN cat /root/.ssh/id_rsa.pub 
RUN echo $(hostname -i) $(hostname) >> /root/.ssh/known_hosts && \
    ssh-keyscan 50.116.35.57 >> /root/.ssh/known_hosts
WORKDIR /root
COPY examplefile .
RUN ssh root@50.116.35.57 -o StrictHostKeyChecking=no
RUN scp examplefile root@50.116.35.57:/root/aws/
RUN echo $SHELL 
CMD ["/bin/bash"]

# to upload the Docker image to the AWS ECR, login first
# aws ecr get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin 658975415077.dkr.ecr.us-east-1.amazonaws.com

# sudo aws ecr get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin 658975415077.dkr.ecr.us-east-1.amazonaws.com