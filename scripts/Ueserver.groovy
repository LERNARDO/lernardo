includeTargets << grailsScript("_GrailsWar" )
	
ant.taskdef(name:"deploy",classname:"org.apache.catalina.ant.DeployTask")
ant.taskdef(name:"start",classname:"org.apache.catalina.ant.DeployTask")
ant.taskdef(name:"deploy",classname:"org.apache.catalina.ant.DeployTask")
ant.taskdef(name:"list",classname:"org.apache.catalina.ant.ListTask")
ant.taskdef(name:"undeploy",classname:"org.apache.catalina.ant.UndeployTask")

target(main: '''\
Deploy the build result to the ue - environment using the tomcat manager

grails deploy do - deploy app to matching ue server instance
grails deploy undo - undeploy app from ue server instance
grails deploy show   - shows to which instance the deploy would go to
''') {
    depends(parseArguments, compile,createConfig)

	def cmd = argsMap.params ? argsMap.params[0] : 'show'
  def mod = argsMap.params[1]
	argsMap.params.clear()

	def app     = config.ueserver.deploy.appname ?: metadata.'app.name'
  def server   = config.ueserver.deploy.server  ?: "http://${app}.customer.uenterprise.de"
  def manager  = config.ueserver.deploy.manager ?: "${server}/manager"
  def user     = config.ueserver.deploy.username ?: "mgr_${app}"
  def pass     = config.ueserver.deploy.password ?: "pwd_${app}"
                                                                        
  def context  ;
  switch (grailsSettings.grailsEnv) {
    case 'development':
      context  = "/dev"
      break ;
    
    default:
      context  = "/${grailsSettings.grailsEnv}"
  }

	switch(cmd) {
    case 'show':
      println "Application $app deployment on ${server}${context}"
      println "ident: $user/$pass"
      list( url:manager, username:user, password:pass)
    break ;

    case 'release':
      updateMeta(metadata)
      buildConfig.grails.war.destFile = "${app}-prod.war"
      war()
    break ;
    

		case 'deploy':
      updateMeta(metadata)
			war()
      println "undeploy $app from ${server}${context}"
      try {
        undeploy(url:manager, path:context, username:user,password:pass)
      } catch (Exception ignore) {}
      println "Application $app deployment on ${server}${context}"
		  deploy(war:warName, url:manager, path:context, username:user, password:pass)
		break

		case 'undeploy':
      println "undeploy $app from ${server}${context}"
		  undeploy(url:manager, path:context, username:user,password:pass)
    break ;

    case 'stop':
      println "stop $app at ${server}${context}"
      undeploy(url:manager, path:context, username:user,password:pass)
    break ;

    case 'start':
      println "(re)start $app from ${server}${context}"
      undeploy(url:manager, path:context, username:user,password:pass)
    break ;
	}

}

setDefaultTarget("main")


private updateMeta(def metadata) {
    println "start re-writing application properties"

    metadata.'deploy.buildnum'  = System.properties.buildnum ?: '0'
    metadata.'deploy.vcsver'    = System.properties.vcsver   ?: '0'
    metadata.'deploy.env'       = grailsSettings.grailsEnv
    metadata.'deploy.timestamp' = new Date().getDateTimeString()

    metadata.persist()
    println "done re-writing application properties"

}