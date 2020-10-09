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
                    serverId: 'Artifactory1',
                    spec: '''{
                          "files": [
                            {
                              "pattern": "/*.war",
                              "target": "libs-snapshot-local"
                            }
                         ]
                    }''',

                    // Optional - Associate the uploaded files with the following custom build name and build number,
                    // as build artifacts.
                    // If not set, the files will be associated with the default build name and build number (i.e the
                    // the Jenkins job name and number).
                    buildName: 'BUILD_NUMBER',
                    buildNumber: 'BUILD_ID'
               )
            }
        }
    }
}