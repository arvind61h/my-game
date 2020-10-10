pipeline{
    agent { label 'master' }
    stages{
        stage('Build and Packaging ')
        {
            steps
            {
                sh 'mvn clean package'

            }
        }
        stage ('uploading Artifacts to binary server') {
            steps{
               rtUpload (
                    serverId: 'Artifactory1',
                    spec: '''{
                          "files": [
                            {
                              "pattern": "*.war",
                              "target": "libs-snapshot-local"
                            }
                         ]
                    }''',
                    buildName: 'BUILD_NUMBER',
                    buildNumber: 'BUILD_ID'
               )
            }
        }
    }
}