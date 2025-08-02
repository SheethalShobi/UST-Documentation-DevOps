mkdir tomcat-app && cd tomcat-app

FROM tomcat:9.0
COPY ./index.html /usr/local/tomcat/webapps/ROOT/index.html

echo '<h1>Welcome to Tomcat on ECS!</h1>' > index.html

docker build -t my-tomcat-app .

aws ecr create-repository --repository-name my-tomcat-app

docker tag my-tomcat-app:latest 267092042432.dkr.ecr.us-east-2.amazonaws.com/my-tomcat-app:latest

docker push 267092042432.dkr.ecr.us-east-2.amazonaws.com/my-tomcat-app:latest
