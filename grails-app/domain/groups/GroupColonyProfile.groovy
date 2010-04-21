package groups

import de.uenterprise.ep.Profile

class GroupColonyProfile extends Profile{

    String description // added on 21.04.2010
    //String generalInformation - removed on 21.04.2010
    //String otherFacilities - removed on 21.04.2010

    String[] representativeName // added on 21.04.2010
    String[] representativeCountry // added on 21.04.2010
    String[] representativeZip // added on 21.04.2010
    String[] representativeCity // added on 21.04.2010
    String[] representativeStreet // added on 21.04.2010
    String[] representativePhone // added on 21.04.2010
    String[] representativeEmail // added on 21.04.2010
    String[] representativeFunction // added on 21.04.2010

    String[] buildingName // added on 21.04.2010
    String[] buildingCountry // added on 21.04.2010
    String[] buildingZip // added on 21.04.2010
    String[] buildingCity // added on 21.04.2010
    String[] buildingStreet // added on 21.04.2010
    String[] buildingPhone // added on 21.04.2010
    String[] buildingEmail // added on 21.04.2010
    String[] buildingAuthority // added on 21.04.2010
  
    static constraints = {
      fullName (blank: false, size: 2..50)
      description (blank: true, maxSize: 500)
    }

}
