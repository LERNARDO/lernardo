class ProfileDataService {
    boolean transactional = false
    Map profiles = [:]


    def initProfiles () {
      profiles.maxi = [name:'maxi', fullName:'Maxi Huber', type:'client', age:13, hoobies:'smoking cigars']
      profiles.franzi = [name:'franzi', fullName:'Franzi Huber', type:'client', age:13, hoobies:'smoking cigars']

      profiles.regina = [name:'regina', fullName:'Regina Toncourt', type:'paed', age:13, hoobies:'jumping around']
      profiles.martin = [name:'martin', fullName:'Marting', type:'paed', age:13, hoobies:'organizing stuff']

      profiles.weissenbach = [name:'weissenbach', fullName:'Nachmittagsbetreuung Weissenbach a.d. Triesting',
                              type:'einrichting', address:'bla bla strasse 515', plz:'9276']

    }


    def addProfile(String name, Map attrs) {
      profiles[name] = attrs
    }

    def getProfile (String name){
      return (profiles[name])
    }

    def listProfiles (String profileType, def nStart, def nMax) {
      // todo: apply filter
      return profiles ;
    }
}
