target(main: "Main target") {

    metadata.'build.buildnum'   = System.properties.buildnum ?: '0'
    metadata.'build.env'        = grailsSettings.grailsEnv

    metadata.persist()
}

setDefaultTarget("main")
