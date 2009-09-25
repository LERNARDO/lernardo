class UrlMappings {
    static mappings = {
      "/prf/$name"{
          controller = 'profile'
          action     = 'show'
	      constraints {
			 // apply constraints here
		  }
	  }


      "/$controller/$action?/$id?"{
	      constraints {
			 // apply constraints here
		  }
	  }
      "/"(controller:'article')//view:"/index")

      "500"(view:'/error')
	}
}
