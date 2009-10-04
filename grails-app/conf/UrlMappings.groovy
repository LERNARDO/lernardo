class UrlMappings {
    static mappings = {
      "/prf/$name/$content?"{
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

      "/"{
        controller = 'app'
        action     = 'home'
      }

      "/start"{
        controller = 'app'
        action     = 'start'
       }

      "500"(view:'/error')
	}
}
