import org.codehaus.groovy.grails.commons.GrailsApplication
import at.uenterprise.erp.base.asset.FileSystemByteStore
import at.uenterprise.erp.base.security.DefaultSecurityManager

// Place your Spring DSL code here
beans = {
  // initialize asset store
  def storeDir = ((GrailsApplication)application).config.at.uenterprise.erp.base.assetStore
  storeDir = storeDir ?: "${System.properties.'user.home'}/.${application.metadata.'app.name'}/assets"
  println ("STORE-ROOT: $storeDir")
  log.info ("installing FileSystemByteStore as default assetStore with storeRoot: $storeDir")

  assetStore (FileSystemByteStore) {bean->
    storeRoot = storeDir
  }

  // initialize security Manager
  securityManager (DefaultSecurityManager) {bean->
    salt = 0x010222562L ;
  }
    
}