Azure DevOps
----------------

## 02 July 2023

* Setup Self Hosted Linux Agent (Standard_B2ms)
* write pipeline for Game of life

## 04 July 2023

* Write pipeline for game of life on microsoft hosted agent.
* Write pipeline for GOL to scan code with sonar cloud

## 05 July 2023

* write pipeline for Spring pet clinic
    * install Jdk 17
    * install mvn from wget `https://dlcdn.apache.org/maven/maven-3/3.9.3/binaries/apache-maven-3.9.3-bin.tar.gz`
    * follow steps below
```bash
sudo wget https://dlcdn.apache.org/maven/maven-3/3.9.3/binaries/apache-maven-3.9.3-bin.tar.gz
sudo tar xzvf apache-maven-3.9.3-bin.tar.gz

sudo mv apache-maven-3.9.3  /opt/maven/

export PATH="/opt/maven/apache-maven-3.9.3/bin:$PATH"
```

  * provide jdk path & mvn path in the pipeline
```yaml
testResultsFiles: '**/surefire-reports/TEST-*.xml'
javaHomeOption: 'Path'
jdkDirectory: '/usr/lib/jvm/java-17-openjdk-amd64'
mavenVersionOption: 'Path'
mavenDirectory: '/opt/maven/apache-maven-3.9.3'
```
  * run the pipeline to check build

* Add Sonar Cloud details as below
    * `SonarCloudPrepare@1`
    * `SonarCloudPublish@1`

* Use `CopyFiles@2` to copy the packaged jar file
* Use `PublishBuildArtifacts@1` to publish the file to Azure Artifacts.

[YAML](/AzureDevOps/spc_normal_sonarcloud/azure-pipelines.yaml)


## 06 July 2023

* SPC pipeline using `${{ parameters.* }}`

[YAML](/AzureDevOps/spc_parameters/azure-pipelines.yaml)

* SPC pipeline using variables
[YAML](/AzureDevOps/spc_variables/azure-pipelines.yaml)

## 07 July 2023

* Building pipelines for Dotnet application [URL](https://learn.microsoft.com/en-us/azure/devops/pipelines/ecosystems/dotnet-core?view=azure-devops&tabs=dotnetfive)


