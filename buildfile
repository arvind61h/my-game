pipeline{
    agent { label 'master' }
    stages{
        stage('Build and Packaging ')
        {
            steps
            {
                sh 'mvn clean package'

            }
            post{
                success{
                    archiveArtifacts artifacts: '**/*.jar, **/*.war', followSymlinks: false
                }
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
                            }"""
                )
            }
        }
    }
}