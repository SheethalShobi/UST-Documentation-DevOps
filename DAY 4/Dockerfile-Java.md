### Creating docker image of Java program
```
mkdir java-docker
cd java-docker
nano HelloWorld.java
```

### In the nano editor of Helloworld.java

```
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello from Dockerized Java on EC2!");
    }
}
```
### Creating Dockerfile
```
nano Dockerfile 
```
and wrote
```
FROM openjdk:17
WORKDIR /app
COPY HelloWorld.java .
RUN javac HelloWorld.java
CMD ["java", "HelloWorld"]
```
to save : ctrl o + enter + ctrl x

### Building image
```
docker build -t java-hello .
```
### Running Docker Container
```
docker run --rm java-hello`
### Output
```
Hello from Dockerized Java on EC2!
```
