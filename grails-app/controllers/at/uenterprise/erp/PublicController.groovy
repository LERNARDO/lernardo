package at.uenterprise.erp

class PublicController {

    def terms = {}

    def privacy = {}

    def imprint = {}

    def start = {
      if (params.loggedOut == "true")
        flash.message = message(code: "loggedOut")
    }
}
