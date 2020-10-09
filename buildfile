pipeline{
    agent { label 'master'}
    stages{
        stage('Build and Packaging ')
        {
            steps
            {
                sh 'mvn clean package'
            }
        }
        stage ('Deploying Artifacts to Artifacts server') {
            steps{
               rtUpload (
                    serverId: "Artifactory1",
                    spec: """{
                            "files": [
                                    {
                                        "pattern": "/*.war",
                                        "target": "libs-snapshot-local"

                                    }
                                ]
                    }""",
                    buildName: 'JOB_NAME',
                    buildNumber: 'BUILD_NUMBER'
                )
            }
        }
    }
}