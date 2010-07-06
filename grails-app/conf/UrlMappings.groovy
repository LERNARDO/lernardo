class UrlMappings {
    static mappings = {

      "/prf/$name/$content?"{
        controller = 'profile'
        action     = 'show'
	     constraints {
			 // apply constraints here
		  }
	   }

      // default mapping
      "/$controller/$action?/$id?"{
	     constraints {
		    // apply constraints here
		  }
	   }

      "/" (controller:'app', action:'home') // public start
      "/start" (controller:'app', action:'start') // private start

      "404"(view:'/404')
      "500"(view:'/500')
      //"500"(view:'/error')
	}
}
