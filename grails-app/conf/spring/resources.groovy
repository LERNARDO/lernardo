import org.codehaus.groovy.grails.commons.GrailsApplication
import at.uenterprise.erp.base.asset.FileSystemByteStore
import at.uenterprise.erp.base.security.DefaultSecurityManager
import at.uenterprise.erp.base.attr.DynAttrSet

// Place your Spring DSL code here
beans = {
    // initialize asset store
    def storeDir = ((GrailsApplication) application).config.at.uenterprise.erp.base.assetStore
    storeDir = storeDir ?: "${System.properties.'user.home'}/.${application.metadata.'app.name'}/.${application.config.customer}/assets"
    //println("STORE-ROOT: $storeDir")
    //log.info ("installing FileSystemByteStore as default assetStore with storeRoot: $storeDir")

    assetStore(FileSystemByteStore) {bean ->
        storeRoot = storeDir
    }

    // initialize security Manager
    securityManager(DefaultSecurityManager) {bean ->
        salt = 0x010222562L;
    }

    application.domainClasses.each {domainClass ->
        def metaProperty = domainClass.metaClass.getMetaProperty("dynattrs")
        //if (metaProperty)
        //  log.info "==> amend dynattr access for: $domainClass"
        domainClass.metaClass.getDas = {
            new DynAttrSet(metaProperty.getProperty(delegate))
        }
    }

}