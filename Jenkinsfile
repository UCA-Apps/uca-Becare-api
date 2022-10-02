/** Written by Mahesh.P ; dt: 12-Sept-2020 .This code will compile the mule project, deploy the code in mule environment, deploy into nexus server and send email to the parties about the deployment status */

pipeline 
{
  agent { label 'master' } 
  tools 
  { 
    maven 'MAVEN_HOME'
  }
  stages 
	{
		stage ('get mule password and deploy the code to mule Server')    
	    	{
				steps
				 {
					  script {
									withCredentials([string(credentialsId: 'mule_password', variable: 'mule_pass')]) {
										
										mule_password = "$mule_pass"
										
									bat "mvn clean deploy -DmuleDeploy -Dmule.home=D:/mule/mule -DanypointUser=${params.mule_user} -DanypointPassword=${mule_password} -DtargetServer=${params.mule_target_srvr} -DtargetEnvironment=${params.mule_target_environment} -DtargetType=${params.mule_target_type} -DdeploymentTimeout=5000000"
								}								
					  }
				 }
			}
			 
		
		

		stage ('Publish the artifact to Nexus repository')    
	    	{
		    steps
		     {
				  script {
					   
						   def mavenPOM = readMavenPom file : 'pom.xml'
						   def nexusRepoName =   "${params.mule_nexus_rep_name}" /** mavenPOM.version.endsWith('SNAPSHOT') ? 'uca-dev-snapshots' : 'uca-test-release' */
						   
						   nexusArtifactUploader artifacts : [
							   [
									artifactId : "${mavenPOM.artifactId}",
									classifier: 'mule-application',
								   file: "C:/Program Files (x86)/Jenkins/workspace/${env.JOB_NAME}/target/${mavenPOM.artifactId}-${mavenPOM.version}-mule-application.jar",
									type: 'jar'
							   ]],
							   
						   credentialsId : 'nexusCred',
						   groupId : 'com.uca',
						   nexusUrl : '10.2.11.102:3001/nexus',
						   nexusVersion : 'nexus2',
						   protocol : 'http',
						   repository : nexusRepoName,
						   version : "${mavenPOM.version}"
					
						}
			   
		     }
        } 
    }
    
	post 
	{
        always 
			   {
				  mail bcc: "${params.mule_mail_bcc}", body: " Hello, \n \n Please find the Job details below: \n \n Status : ${currentBuild.currentResult} \n Job: ${env.JOB_NAME} \n Build #: build ${env.BUILD_NUMBER} \n \n More info at: ${env.BUILD_URL}. \n \n \n Regards, \n Rasool", cc: "${params.mule_mail_cc}" , from: "${params.mule_mail_from}", replyTo: '', subject: "Auto Email Notification: Jenkins Job ${currentBuild.currentResult} in ${params.mule_target_environment} environment. : Job ${env.JOB_NAME} *DO NOT REPLY* ", to: "${params.mule_mail_to}"  
			   }
    }
}