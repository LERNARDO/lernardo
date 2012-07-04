class UrlMappings {
    static mappings = {

        "/prf/$name/$content?" {
            controller = 'profile'
            action = 'show'
            constraints {
                // apply constraints here
            }
        }

        // default mapping
        "/$controller/$action?/$id?" {
            constraints {
                // apply constraints here
            }
        }

        "/"(controller: 'security', action: 'login')
        "/"(controller: 'public', action: 'start') // public start
        "/start"(controller: 'app', action: 'start') // private start

        "404"(controller: 'app', action: 'error404')
        "500"(controller: 'app', action: 'error500') //"500"(view:'/500')
        //"500"(view:'/error')
    }
}
