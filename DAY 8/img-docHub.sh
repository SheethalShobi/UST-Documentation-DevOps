root@ip-172-31-89-73:/home/ubuntu/docker-k8s# docker build -t sheethalshobi/myapp
ERROR: "docker buildx build" requires exactly 1 argument.
See 'docker buildx build --help'.

Usage:  docker buildx build [OPTIONS] PATH | URL | -

Start a build
root@ip-172-31-89-73:/home/ubuntu/docker-k8s# docker build -t sheethalshobi/myapp .
[+] Building 63.1s (13/13) FINISHED                                                     docker:default
 => [internal] load build definition from Dockerfile                                              0.0s
 => => transferring dockerfile: 520B                                                              0.0s
 => [internal] load metadata for docker.io/library/ubuntu:latest                                  0.4s
 => [internal] load .dockerignore                                                                 0.0s
 => => transferring context: 2B                                                                   0.0s
 => [1/8] FROM docker.io/library/ubuntu:latest@sha256:a08e551cb33850e4740772b38217fc1796a66da250  2.3s
 => => resolve docker.io/library/ubuntu:latest@sha256:a08e551cb33850e4740772b38217fc1796a66da250  0.0s
 => => sha256:a08e551cb33850e4740772b38217fc1796a66da2506d312abe51acda354ff061 6.69kB / 6.69kB    0.0s
 => => sha256:4f1db91d9560cf107b5832c0761364ec64f46777aa4ec637cca3008f287c975e 424B / 424B        0.0s
 => => sha256:65ae7a6f3544bd2d2b6d19b13bfc64752d776bc92c510f874188bfd404d205a3 2.30kB / 2.30kB    0.0s
 => => sha256:32f112e3802cadcab3543160f4d2aa607b3cc1c62140d57b4f5441384f40e927 29.72MB / 29.72MB  0.4s
 => => extracting sha256:32f112e3802cadcab3543160f4d2aa607b3cc1c62140d57b4f5441384f40e927         1.7s
 => [internal] load build context                                                                 0.0s
 => => transferring context: 3.41kB                                                               0.0s
 => [2/8] RUN apt-get -y update && apt-get -y upgrade                                             8.1s
 => [3/8] RUN apt-get -y install openjdk-8-jdk wget                                              42.5s
 => [4/8] RUN mkdir /usr/local/tomcat                                                             0.3s
 => [5/8] RUN wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.107/bin/apache-tomcat-9.0.1  2.2s
 => [6/8] RUN cd /tmp && tar xvfz tomcat.tar.gz                                                   0.6s
 => [7/8] RUN cp -Rv /tmp/apache-tomcat-9.0.107/* /usr/local/tomcat/                              0.4s
 => [8/8] COPY target/HelloWorld-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/                    0.0s
 => exporting to image                                                                            6.1s
 => => exporting layers                                                                           6.1s
 => => writing image sha256:b7eada6bbd9fd530def628bf34ca15650ce3c1f6ef2acb8b556d81cc7a942e1a      0.0s
 => => naming to docker.io/sheethalshobi/myapp                                                    0.0s

 1 warning found (use docker --debug to expand):
 - JSONArgsRecommended: JSON arguments recommended for CMD to prevent unintended behavior related to OS signals (line 10)
root@ip-172-31-89-73:/home/ubuntu/docker-k8s# docker login -u sheethalshobi -p
flag needs an argument: 'p' in -p

Usage:  docker login [OPTIONS] [SERVER]

Run 'docker login --help' for more information
root@ip-172-31-89-73:/home/ubuntu/docker-k8s# docker login

USING WEB-BASED LOGIN

i Info → To sign in with credentials on the command line, use 'docker login -u <username>'


Your one-time device confirmation code is: RJKH-CVLB
Press ENTER to open your browser or submit your device code here: https://login.docker.com/activate

Waiting for authentication in the browser…


WARNING! Your credentials are stored unencrypted in '/root/snap/docker/3265/.docker/config.json'.
Configure a credential helper to remove this warning. See
https://docs.docker.com/go/credential-store/

Login Succeeded
root@ip-172-31-89-73:/home/ubuntu/docker-k8s# docker push sheethalshobi/myapp
Using default tag: latest
The push refers to repository [docker.io/sheethalshobi/myapp]
b4ed6c89fe51: Pushed
77952c72c0b4: Pushed
0386070976d4: Pushed
714273cf4b2b: Pushed
ac7fa329aa30: Pushed
aec5bd477b90: Pushed
36614defb9e1: Pushed
107cbdaeec04: Mounted from library/ubuntu
latest: digest: sha256:22fe72460ebf8a9ead8a0062243beb58990a3895bd48af0a48094a14b4e87e65 size: 2005
root@ip-172-31-89-73:/home/ubuntu/docker-k8s# kubectl run mypod --image=sheethalshobi/myapp
pod/mypod created
root@ip-172-31-89-73:/home/ubuntu/docker-k8s# kubectl get pod
NAME                              READY   STATUS              RESTARTS   AGE
mypod                             0/1     ContainerCreating   0          12s
nginx                             1/1     Running             0          25m
nginx-deployment-f5d9744f-r4x29   1/1     Running             0          12m
root@ip-172-31-89-73:/home/ubuntu/docker-k8s# kubectl get pod
NAME                              READY   STATUS              RESTARTS   AGE
mypod                             0/1     ContainerCreating   0          18s
nginx                             1/1     Running             0          25m
nginx-deployment-f5d9744f-r4x29   1/1     Running             0          12m
root@ip-172-31-89-73:/home/ubuntu/docker-k8s# kubectl get po -o wide
NAME                              READY   STATUS              RESTARTS   AGE   IP          NODE              NOMINATED NODE   READINESS GATES
mypod                             0/1     ContainerCreating   0          28s   <none>      ip-172-31-89-73   <none>           <none>
nginx                             1/1     Running             0          25m   10.32.0.4   ip-172-31-89-73   <none>           <none>
nginx-deployment-f5d9744f-r4x29   1/1     Running             0          12m   10.32.0.5   ip-172-31-89-73   <none>           <none>
root@ip-172-31-89-73:/home/ubuntu/docker-k8s# kubectl get po -o wide
NAME                              READY   STATUS              RESTARTS   AGE   IP          NODE              NOMINATED NODE   READINESS GATES
mypod                             0/1     ContainerCreating   0          38s   <none>      ip-172-31-89-73   <none>           <none>
nginx                             1/1     Running             0          25m   10.32.0.4   ip-172-31-89-73   <none>           <none>
nginx-deployment-f5d9744f-r4x29   1/1     Running             0          12m   10.32.0.5   ip-172-31-89-73   <none>           <none>
root@ip-172-31-89-73:/home/ubuntu/docker-k8s# kubectl get pod
NAME                              READY   STATUS    RESTARTS   AGE
mypod                             1/1     Running   0          49s
nginx                             1/1     Running   0          25m
nginx-deployment-f5d9744f-r4x29   1/1     Running   0          13m
root@ip-172-31-89-73:/home/ubuntu/docker-k8s# kubectl get po -o wide
NAME                              READY   STATUS    RESTARTS   AGE   IP          NODE              NOMINATED NODE   READINESS GATES
mypod                             1/1     Running   0          56s   10.32.0.6   ip-172-31-89-73   <none>           <none>
nginx                             1/1     Running   0          26m   10.32.0.4   ip-172-31-89-73   <none>           <none>
nginx-deployment-f5d9744f-r4x29   1/1     Running   0          13m   10.32.0.5   ip-172-31-89-73   <none>           <none>
root@ip-172-31-89-73:/home/ubuntu/docker-k8s# curl 10.32.0.6
curl: (7) Failed to connect to 10.32.0.6 port 80: Connection refused
root@ip-172-31-89-73:/home/ubuntu/docker-k8s# curl 10.32.0.6:8080



<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <title>Apache Tomcat/9.0.107</title>
        <link href="favicon.ico" rel="icon" type="image/x-icon" />
        <link href="tomcat.css" rel="stylesheet" type="text/css" />
    </head>

    <body>
        <div id="wrapper">
            <div id="navigation" class="curved container">
                <span id="nav-home"><a href="https://tomcat.apache.org/">Home</a></span>
                <span id="nav-hosts"><a href="/docs/">Documentation</a></span>
                <span id="nav-config"><a href="/docs/config/">Configuration</a></span>
                <span id="nav-examples"><a href="/examples/">Examples</a></span>
                <span id="nav-wiki"><a href="https://cwiki.apache.org/confluence/display/TOMCAT/">Wiki</a></span>
                <span id="nav-lists"><a href="https://tomcat.apache.org/lists.html">Mailing Lists</a></span>
                <span id="nav-help"><a href="https://tomcat.apache.org/findhelp.html">Find Help</a></span>
                <br class="separator" />
            </div>
            <div id="asf-box">
                <h1>Apache Tomcat/9.0.107</h1>
            </div>
            <div id="upper" class="curved container">
                <div id="congrats" class="curved container">
                    <h2>If you're seeing this, you've successfully installed Tomcat. Congratulations!</h2>
                </div>
                <div id="notice">
                    <img id="tomcat-logo" src="tomcat.svg" alt="[tomcat logo]" />
                    <div id="tasks">
                        <h3>Recommended Reading:</h3>
                        <h4><a href="/docs/security-howto.html">Security Considerations How-To</a></h4>
                        <h4><a href="/docs/manager-howto.html">Manager Application How-To</a></h4>
                        <h4><a href="/docs/cluster-howto.html">Clustering/Session Replication How-To</a></h4>
                    </div>
                </div>
                <div id="actions">
                    <div class="button">
                        <a class="container shadow" href="/manager/status"><span>Server Status</span></a>
                    </div>
                    <div class="button">
                        <a class="container shadow" href="/manager/html"><span>Manager App</span></a>
                    </div>
                    <div class="button">
                        <a class="container shadow" href="/host-manager/html"><span>Host Manager</span></a>
                    </div>
                </div>
                <br class="separator" />
            </div>
            <div id="middle" class="curved container">
                <h3>Developer Quick Start</h3>
                <div class="col25">
                    <div class="container">
                        <p><a href="/docs/setup.html">Tomcat Setup</a></p>
                        <p><a href="/docs/appdev/">First Web Application</a></p>
                    </div>
                </div>
                <div class="col25">
                    <div class="container">
                        <p><a href="/docs/realm-howto.html">Realms &amp; AAA</a></p>
                        <p><a href="/docs/jndi-datasource-examples-howto.html">JDBC DataSources</a></p>
                    </div>
                </div>
                <div class="col25">
                    <div class="container">
                        <p><a href="/examples/">Examples</a></p>
                    </div>
                </div>
                <div class="col25">
                    <div class="container">
                        <p><a href="https://cwiki.apache.org/confluence/display/TOMCAT/Specifications">Servlet Specifications</a></p>
                        <p><a href="https://cwiki.apache.org/confluence/display/TOMCAT/Tomcat+Versions">Tomcat Versions</a></p>
                    </div>
                </div>
                <br class="separator" />
            </div>
            <div id="lower">
                <div id="low-manage" class="">
                    <div class="curved container">
                        <h3>Managing Tomcat</h3>
                        <p>For security, access to the <a href="/manager/html">manager webapp</a> is restricted.
                        Users are defined in:</p>
                        <pre>$CATALINA_HOME/conf/tomcat-users.xml</pre>
                        <p>In Tomcat 9.0 access to the manager application is split between
                           different users. &nbsp; <a href="/docs/manager-howto.html">Read more...</a></p>
                        <br />
                        <h4><a href="/docs/RELEASE-NOTES.txt">Release Notes</a></h4>
                        <h4><a href="/docs/changelog.html">Changelog</a></h4>
                        <h4><a href="https://tomcat.apache.org/migration.html">Migration Guide</a></h4>
                        <h4><a href="https://tomcat.apache.org/security.html">Security Notices</a></h4>
                    </div>
                </div>
                <div id="low-docs" class="">
                    <div class="curved container">
                        <h3>Documentation</h3>
                        <h4><a href="/docs/">Tomcat 9.0 Documentation</a></h4>
                        <h4><a href="/docs/config/">Tomcat 9.0 Configuration</a></h4>
                        <h4><a href="https://cwiki.apache.org/confluence/display/TOMCAT/">Tomcat Wiki</a></h4>
                        <p>Find additional important configuration information in:</p>
                        <pre>$CATALINA_HOME/RUNNING.txt</pre>
                        <p>Developers may be interested in:</p>
                        <ul>
                            <li><a href="https://tomcat.apache.org/bugreport.html">Tomcat 9.0 Bug Database</a></li>
                            <li><a href="/docs/api/index.html">Tomcat 9.0 JavaDocs</a></li>
                            <li><a href="https://github.com/apache/tomcat/tree/9.0.x">Tomcat 9.0 Git Repository at GitHub</a></li>
                        </ul>
                    </div>
                </div>
                <div id="low-help" class="">
                    <div class="curved container">
                        <h3>Getting Help</h3>
                        <h4><a href="https://tomcat.apache.org/faq/">FAQ</a> and <a href="https://tomcat.apache.org/lists.html">Mailing Lists</a></h4>
                        <p>The following mailing lists are available:</p>
                        <ul>
                            <li id="list-announce"><strong><a href="https://tomcat.apache.org/lists.html#tomcat-announce">tomcat-announce</a><br />
                                Important announcements, releases, security vulnerability notifications. (Low volume).</strong>
                            </li>
                            <li><a href="https://tomcat.apache.org/lists.html#tomcat-users">tomcat-users</a><br />
                                User support and discussion
                            </li>
                            <li><a href="https://tomcat.apache.org/lists.html#taglibs-user">taglibs-user</a><br />
                                User support and discussion for <a href="https://tomcat.apache.org/taglibs/">Apache Taglibs</a>
                            </li>
                            <li><a href="https://tomcat.apache.org/lists.html#tomcat-dev">tomcat-dev</a><br />
                                Development mailing list, including commit messages
                            </li>
                        </ul>
                    </div>
                </div>
                <br class="separator" />
            </div>
            <div id="footer" class="curved container">
                <div class="col20">
                    <div class="container">
                        <h4>Other Downloads</h4>
                        <ul>
                            <li><a href="https://tomcat.apache.org/download-connectors.cgi">Tomcat Connectors</a></li>
                            <li><a href="https://tomcat.apache.org/download-native.cgi">Tomcat Native</a></li>
                            <li><a href="https://tomcat.apache.org/taglibs/">Taglibs</a></li>
                            <li><a href="/docs/deployer-howto.html">Deployer</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col20">
                    <div class="container">
                        <h4>Other Documentation</h4>
                        <ul>
                            <li><a href="https://tomcat.apache.org/connectors-doc/">Tomcat Connectors</a></li>
                            <li><a href="https://tomcat.apache.org/connectors-doc/">mod_jk Documentation</a></li>
                            <li><a href="https://tomcat.apache.org/native-doc/">Tomcat Native</a></li>
                            <li><a href="/docs/deployer-howto.html">Deployer</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col20">
                    <div class="container">
                        <h4>Get Involved</h4>
                        <ul>
                            <li><a href="https://tomcat.apache.org/getinvolved.html">Overview</a></li>
                            <li><a href="https://tomcat.apache.org/source.html">Source Repositories</a></li>
                            <li><a href="https://tomcat.apache.org/lists.html">Mailing Lists</a></li>
                            <li><a href="https://cwiki.apache.org/confluence/display/TOMCAT/">Wiki</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col20">
                    <div class="container">
                        <h4>Miscellaneous</h4>
                        <ul>
                            <li><a href="https://tomcat.apache.org/contact.html">Contact</a></li>
                            <li><a href="https://tomcat.apache.org/legal.html">Legal</a></li>
                            <li><a href="https://www.apache.org/foundation/sponsorship.html">Sponsorship</a></li>
                            <li><a href="https://www.apache.org/foundation/thanks.html">Thanks</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col20">
                    <div class="container">
                        <h4>Apache Software Foundation</h4>
                        <ul>
                            <li><a href="https://tomcat.apache.org/whoweare.html">Who We Are</a></li>
                            <li><a href="https://tomcat.apache.org/heritage.html">Heritage</a></li>
                            <li><a href="https://www.apache.org">Apache Home</a></li>
                            <li><a href="https://tomcat.apache.org/resources.html">Resources</a></li>
                        </ul>
                    </div>
                </div>
                <br class="separator" />
            </div>
            <p class="copyright">Copyright &copy;1999-2025 Apache Software Foundation.  All Rights Reserved</p>
        </div>
    </body>

</html>
