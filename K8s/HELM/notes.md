#### HELM

Helm is a package manager for Kubernetes.

Helm package contains resource definitions to run an application,tool, or service inside of a Kubernetes cluster.

Streamlines installing and managing Kubernetes applications. 

### Features:
#### 1)Helm Charts
- Charts	help define,install and upgrade complex kubernetes application.
- Bundle of YAML files
- Create your own Helm charts with Helm
- Push the to Helm repository which can be public or private - Helm Hub is a	public repository of charts for popular software
- Download and use existing ones - 	We can also retrieve charts from third-party repositories, author and contribute our own charts	to someone else’s repository.


Databases like MongoDB,monitoring apps like Prometheus etc have these helm charts installed on them 

	Install helm
	Reference:
		https://helm.sh/docs/intro/install/
		
		$ curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
		$ chmod 700 get_helm.sh
		$ ./get_helm.sh

--------------------------------------------------------------------------------------

	To find available charts use the search command.
	
----------------------------------------------------------------------------------------	
	helm search hub
		Searches in https://artifacthub.io/
		list all helm charts available in that location.

	helm search repo 
	searches the repositories that you have added to your local helm client
		
	helm search --help
			
	#check helm is working
	helm
	#this will print lot of information including
	default configuration path
	default cache path
	default data path

#### 2)Templating Engine / Config Values

Suppose we have multiple microservices and deployment and service of each of those are pretty much the same with only difference in version tags like deployment name,docker img etc then we need to write seperate yaml files for each of these so multiple deplOyments where each one has its own appln name and version .
Then with helm we can define a common blueprint for all the microservices and the values that are dynamic ie going to change are replaced by placeholders and that would be a template file where in syntax you have some values that going to take original value of it from external configurations.

Highly useful in ci/cd pipelines where those template files can be used and replace the values before deploying.

Suppose we have an application that needs to go for development,staging and production ,then instead of doing the task individually for each stage we can create helm charts with all necessary helm files that particular deployment needs and then redeploy them if there are different communites cluster environments ,this makes deployment part easier.

### HELM CHART STRUCTURE

Directory structure 
```
mychart/ 
 Chart.yaml 
 values.yaml/ 
 charts/ 
 templates/ 
```
----------------------------------------
```
helm install <chartname>
```
template files will be filled with the values from values.yaml file

Optionally other files like Readme or licence files are also present

### How values are injected into template files ?
1. while giving command can specify like
 ```
helm install --values=my-values.yaml <chartname>
```
then can create a my-values.yaml file and override one of those values or can add some new attributes and those will be merged and resolved into .values object

2. Using set flag command
 ```
helm install set version=2.0.0
```
#### 3)Release Management
 A **release** is a running instance of a Helm chart, just like a container is an instance of an image.
 This is based on its setup
 
 Eg in helm version 2 and 3
 - In Version 2,it comes as helm client and server known as Tiller 
- whenever u run helm client,helm files will sent that to tiller that runs or has to run on k8 cluster
and tiller then execute this request and create components from this helm files inside the cluster and this feature of helm provides additional value management which is release management

- The way helm client -server setup works is that whenever you create or change the deployment,tiller will store a copy of each configuration clients and for future references thus creating a history of chart executions so when u upgrade the helm deployment the changes will be applied to existing deployment instead of removing it and ceating a new one and instead if it the upgrade was wrong then we can rollback that upgrade using :
 ```
helm rollback <chartname>
```

#### Disadvantages
Tiller has too much power governance inside k8 cluster
Needs too much permissions and makes it a big security issue and thats y removed tiller part in version 3

------------

#### ADVANTAGES OF HELM:
1)Manage Complexity : 
Charts describe even the most complex apps, provide repeatable application installation, and serve as a single point of authority.

2)Easy Updates :
Takes the pain out of updates with in-place upgrades and custom hooks.

3)Simple Sharing :
Charts are easy to version, share, and host on public or private servers.

4)Rollbacks : 
Use helm rollback to roll back to an older version of a release with ease.

-------------

### Use Helm to deploy a chart

Initialize a Helm chart repository

$ helm repo add my-charts https://my-charts.storage.googleapis.com

$ helm repo update

$ helm repo list

$ helm search repo mysql

$ helm show values stable/mysql

$ helm install mysqldb stable/mysql

Install it in a Kubernetes namespace
$ helm install mysqldb --namespace db-system stable/mysql

To pass values

$ helm install --set user.name='student',user.password='passw0rd' stable/mysql

$ helm install --values myvalues.yaml stable/mysql

$ helm upgrade

$ helm uninstall mysqldb
