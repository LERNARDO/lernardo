package standard
class GeoCoderService {

  boolean transactional = false

  // Template: http://ws.geonames.org/search?country=AT&name_equals=weissenbach%20an%20der%20triesting&style=full
  // unfortunately GeoNames doesn't allow parameters for street and streetnumber so the result is rough
  def geocodeLocation(String name) {
    def base = "http://ws.geonames.org/search?"
    def qs = []
    qs << "country=AT"
    qs << "name_equals=" + URLEncoder.encode(name)
    qs << "style=full"
    def url = new URL(base + qs.join("&"))
    def connection = url.openConnection()

    def result = [:]
    if(connection.responseCode == 200){
      def xml = connection.content.text
      def geonames = new XmlSlurper().parseText(xml)
      result.lat = geonames.geoname.lat as String
      result.lng = geonames.geoname.lng as String
    }
    else{
      log.error("GeocoderService.geocodeLocation FAILED")
      log.error(url)
      log.error(connection.responseCode)
      log.error(connection.responseMessage)
    }
    return result
  }

}
